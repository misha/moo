import 'package:moo/constants.dart';
import 'package:moo/fs/objects/directory.dart';
import 'package:moo/fs/objects/file_type.dart';
import 'package:moo/fs/objects/file.dart';
import 'package:moo/fs/objects/location.dart';
import 'package:moo/fs/objects/selection.dart';

export 'package:moo/fs/objects/directory.dart';
export 'package:moo/fs/objects/file_type.dart';
export 'package:moo/fs/objects/file.dart';
export 'package:moo/fs/objects/location.dart';
export 'package:moo/fs/objects/selection.dart';

typedef LocationWatcher = Function(File? file);
typedef DirectoryWatcher = Function(Directory directory);

class FileSystem {
  FileSystem({
    this.size = 0,
  }) : assert(size >= 0 && size <= MAX_FS_SIZE);

  final int size;

  var _id = 0;
  final _files = <int, File>{};
  final _fileIndex = <File, Location>{};
  final _locationIndex = <Location, File>{};
  final _fileTypeIndex = <FileType, Set<File>>{};
  final _directories = <FileType, Directory>{};
  final _locationWatchers = <Location, List<LocationWatcher>>{};
  final _directoryWatchers = <Directory, List<DirectoryWatcher>>{};

  File file(int id) => _files[id]!;
  Directory directory(FileType type) => _directories[type]!;
  File? contents(Location location) => _locationIndex[location];
  bool hasContents(Location location) => contents(location) != null;
  bool hasNoContents(Location location) => contents(location) == null;
  Location location(File file) => _fileIndex[file]!;
  Iterable<File> collect(FileType type) => _fileTypeIndex[type] ?? const [];

  Iterable<File> get files => _fileIndex.keys;
  Iterable<Directory> get directories => _directories.values;
  bool get isEmpty => files.isEmpty;
  bool get isNotEmpty => files.isNotEmpty;

  Directory createDirectory(FileType type, int capacity) {
    assert(!_directories.containsKey(type));
    final directory = Directory(type, capacity);
    _directories[type] = directory;
    _fileTypeIndex[type] = {};
    return directory;
  }

  File createFile(FileType type, Location target) {
    if (hasContents(target)) {
      throw StateError('Target is not empty.');
    }

    final file = File(_id++, type);
    _create(file, target);
    return file;
  }

  void moveFile(File file, Location target) {
    _move(file, target);
  }

  void swapFiles(File a, File b) {
    _move(a, location(b));
  }

  void archiveFile(File file, Directory directory) {
    assert(file.type == directory.type);
    _delete(file);
    if (directory.file()) _notifyDirectory(directory);
  }

  bool isInBounds(Location location) {
    return location.x >= 0 && //
        location.y >= 0 &&
        location.x < size &&
        location.y < size;
  }

  Selection select(Location origin, int width, int height) {
    final locations = <Location>{};

    for (var x = origin.x; x < origin.x + width; x += 1) {
      for (var y = origin.y; y < origin.y + height; y += 1) {
        final location = Location(x, y);

        if (hasContents(location)) {
          locations.add(location);
        }
      }
    }

    if (locations.isEmpty) {
      return Selection.empty;
    }

    return Selection(
      origin: origin,
      width: width,
      height: height,
      locations: locations,
    );
  }

  bool canMoveSelection(Selection selection, Location target) {
    final offset = target - selection.origin;

    for (final location in selection.locations) {
      final newLocation = location + offset;
      if (!isInBounds(newLocation)) return false;
      if (selection.contains(newLocation)) continue;
      if (hasContents(newLocation)) return false;
    }

    return true;
  }

  bool moveSelection(Selection selection, Location target) {
    if (!canMoveSelection(selection, target)) return false;
    final offset = target - selection.origin;
    final moves = <(File, Location)>[];

    for (final location in selection.locations) {
      final file = contents(location);
      if (file == null) throw StateError('Stale selection.');
      moves.add((file, location + offset));
    }

    for (final (file, target) in moves) {
      _move(file, target);
    }

    return true;
  }

  void _create(File file, Location target) {
    _files[file.id] = file;
    _move(file, target);
    assert(_fileTypeIndex.containsKey(file.type));
    _fileTypeIndex[file.type]!.add(file);
  }

  void _move(File file, Location target) {
    final origin = _fileIndex[file];
    final displaced = _locationIndex[target];

    _fileIndex[file] = target;
    _locationIndex[target] = file;

    if (displaced != null && origin != null) {
      _fileIndex[displaced] = origin;
      _locationIndex[origin] = displaced;
    } else if (origin != null) {
      _locationIndex.remove(origin);
    }

    _notifyLocation(target);
    if (origin != null) _notifyLocation(origin);
  }

  void _delete(File file) {
    final location = _fileIndex[file];
    _files.remove(file.id);
    _fileIndex.remove(file);
    _locationIndex.remove(location);
    _fileTypeIndex[file.type]!.remove(file);
    if (location != null) _notifyLocation(location);
  }

  void Function() watchLocation(Location location, LocationWatcher watcher) {
    final watchers = _locationWatchers.putIfAbsent(location, () => []);
    watchers.add(watcher);
    return () => watchers.remove(watcher);
  }

  void Function() watchDirectory(Directory directory, DirectoryWatcher watcher) {
    final watchers = _directoryWatchers.putIfAbsent(directory, () => []);
    watchers.add(watcher);
    return () => watchers.remove(watcher);
  }

  void _notifyLocation(Location location) {
    final watchers = _locationWatchers[location];
    if (watchers == null) return;
    final file = contents(location);
    for (final watcher in watchers) watcher(file);
  }

  void _notifyDirectory(Directory directory) {
    final watchers = _directoryWatchers[directory];
    if (watchers == null) return;
    for (final watcher in watchers) watcher(directory);
  }
}
