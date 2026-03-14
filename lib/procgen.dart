import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/extensions.dart';

import 'package:moo/fs/file_system.dart';

const _MOVE_DIRECTIONS = <Location>[
  .new(-1, 0),
  .new(1, 0),
  .new(0, -1),
  .new(0, 1),
];

class Procgen {
  Procgen({
    this.minClusterSize = 2,
    this.moveProbability = 0.5,
    this.maxMoveDistance = 3,
    this.maxSwapDistance = 5,
    this.seed,
  }) : _rng = Random(seed) {
    _exts = .unmodifiable([
      for (final group in FileGroup.values)
        FileType.values
            .where((type) => type.group == group) //
            .toList()
            .random(_rng),
    ]);
  }

  final int minClusterSize;
  final double moveProbability;
  final int maxMoveDistance;
  final int maxSwapDistance;
  final int? seed;

  late final List<FileType> _exts;
  final Random _rng;

  /// Generates a new, scrambled [FileSystem].
  ///
  /// The system is procedurally generated as follows:
  ///
  ///   1. set up directories
  ///   2. allocate file blocks
  ///   3. apply transformations
  ///
  /// The available transformations are:
  ///
  ///   - Move: pick a random contiguous cluster of same-file type files
  ///     and slide it 1–[maxMoveDistance] cells in a cardinal direction.
  ///   - Swap: pick two files of different file types within
  ///     [maxSwapDistance] Chebyshev distance and swap their positions.
  ///
  /// Move is chosen with [moveProbability] probability, swap otherwise.
  ///
  /// Constraints:
  ///
  ///   - Clusters must contain at least [minClusterSize] files.
  ///   - Moves must land entirely within bounds and on free cells.
  ///   - Swaps only occur between files of different file types.
  FileSystem generate({
    required int types,
    required int filesPerType,
    required int transformations,
    required int size,
  }) {
    assert(types >= 1 && types <= 5);
    assert(filesPerType > 0);
    assert(transformations >= 0);
    assert(types * filesPerType <= size * size);

    attempts:
    for (var attempt = 0; attempt < 100; attempt += 1) {
      final fs = FileSystem(size: size);

      for (final type in _exts.take(types)) {
        // TODO: Randomly allocate slightly different numbers of each type
        //  based on a distribution parameter.
        fs.createDirectory(type, filesPerType);
        final (width, height) = _computeSize(filesPerType);
        final origin = _allocate(fs, width, height);

        if (origin == null) {
          continue attempts;
        }

        for (var x = origin.x; x < origin.x + width; x += 1) {
          for (var y = origin.y; y < origin.y + height; y += 1) {
            fs.createFile(type, Location(x, y));
          }
        }
      }

      for (var i = 0; i < transformations; i += 1) {
        if (_rng.nextDouble() < moveProbability) {
          _move(fs);
        } else {
          _swap(fs);
        }
      }

      return fs;
    }

    throw StateError('Failed to generate.');
  }

  Location? _allocate(FileSystem fs, int width, int height) {
    final candidates = <Location>[];

    for (var x = 0; x <= fs.size - width; x += 1) {
      for (var y = 0; y <= fs.size - height; y += 1) {
        candidates.add(Location(x, y));
      }
    }

    candidates.shuffle(_rng);

    for (final origin in candidates) {
      final selection = fs.select(origin, width, height);

      if (selection.isEmpty) {
        return origin;
      }
    }

    return null;
  }

  void _move(FileSystem fs) {
    final types = fs.directories.map((directory) => directory.type).toList();
    types.shuffle(_rng);

    for (final type in types) {
      final clusters = _computeClusters(fs, type);
      if (clusters.isEmpty) continue;
      final cluster = clusters[_rng.nextInt(clusters.length)];

      for (final direction in _MOVE_DIRECTIONS.shuffled(_rng)) {
        final distance = 1 + _rng.nextInt(maxMoveDistance);
        final offset = Location(direction.x * distance, direction.y * distance);
        final destination = cluster.origin + offset;

        if (fs.canMoveSelection(cluster, destination)) {
          fs.moveSelection(cluster, destination);
          return;
        }
      }
    }
  }

  void _swap(FileSystem fs) {
    final files = fs.files.toList();
    final pairs = <(File, File)>[];

    for (var i = 0; i < files.length; i += 1) {
      for (var j = i + 1; j < files.length; j += 1) {
        final a = files[i];
        final b = files[j];

        if (a.type != b.type && _computeChebyshev(fs, a, b) <= maxSwapDistance) {
          pairs.add((a, b));
        }
      }
    }

    if (pairs.isEmpty) return;
    final (a, b) = pairs[_rng.nextInt(pairs.length)];
    fs.swapFiles(a, b);
  }

  List<Selection> _computeClusters(FileSystem fs, FileType type) {
    final files = fs.collect(type);
    if (files.length < minClusterSize) return const [];

    final locations = files.map(fs.location).toSet();
    final clusters = <Selection>[];

    for (var y = 0; y < fs.size; y += 1) {
      for (var x = 0; x < fs.size; x += 1) {
        for (var height = 1; height <= fs.size - y; height += 1) {
          for (var width = 1; width <= fs.size - x; width += 1) {
            final size = width * height;

            if (size < minClusterSize || size > locations.length) {
              continue;
            }

            final selection = fs.select(Location(x, y), width, height);

            if (selection.length == size && locations.containsAll(selection.locations)) {
              clusters.add(selection);
            }
          }
        }
      }
    }

    return clusters;
  }

  static (int, int) _computeSize(int area) {
    var bestWidth = area;
    var bestHeight = 1;
    var bestDifference = area - 1;

    for (var width = 1; width <= area; width += 1) {
      if (area % width != 0) continue;
      final height = area ~/ width;
      final difference = (width - height).abs();

      if (difference < bestDifference) {
        bestDifference = difference;
        bestWidth = width;
        bestHeight = height;
      }
    }

    if (bestWidth < bestHeight) return (bestHeight, bestWidth);
    return (bestWidth, bestHeight);
  }

  static int _computeChebyshev(FileSystem fs, File a, File b) {
    final locationA = fs.location(a);
    final locationB = fs.location(b);

    return max(
      (locationA.x - locationB.x).abs(),
      (locationA.y - locationB.y).abs(),
    );
  }
}
