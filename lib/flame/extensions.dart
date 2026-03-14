import 'package:flame/extensions.dart';

import 'package:moo/constants.dart';
import 'package:moo/fs/file_system.dart';

extension OffsetToLocation on Offset {
  Location toLocation() {
    return Location((dx / CELL_SIZE).floor(), (dy / CELL_SIZE).floor());
  }
}

extension Vector2ToLocation on Vector2 {
  Location toLocation() {
    return Location((x / CELL_SIZE).floor(), (y / CELL_SIZE).floor());
  }
}

extension LocationToVector2 on Location {
  Vector2 toVector2() {
    return Vector2(x * CELL_SIZE, y * CELL_SIZE);
  }
}
