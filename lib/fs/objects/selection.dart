import 'package:collection/collection.dart';

import 'package:moo/fs/objects/location.dart';

class Selection {
  factory Selection.from(Set<Location> locations) {
    assert(locations.isNotEmpty);

    final xs = locations.map((location) => location.x);
    final ys = locations.map((location) => location.y);
    final minX = xs.min;
    final maxX = xs.max;
    final minY = ys.min;
    final maxY = ys.max;

    return Selection(
      origin: Location(minX, minY),
      width: maxX - minX + 1,
      height: maxY - minY + 1,
      locations: locations,
    );
  }

  const Selection({
    required this.origin,
    required this.width,
    required this.height,
    this.locations = const {},
  });

  static const empty = Selection(
    origin: Location(0, 0),
    width: 0,
    height: 0,
  );

  final Location origin;
  final int width;
  final int height;
  final Set<Location> locations;

  bool get isEmpty => locations.isEmpty;
  bool get isNotEmpty => locations.isNotEmpty;
  int get length => locations.length;

  bool contains(Location location) => locations.contains(location);
}
