import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

/// A component that draws a grid with as many cells as possible.
class GridComponent extends PositionComponent with Fuse, HasPaint {
  GridComponent({
    required this.cellSize,
    required Color color,
    super.anchor,
    super.position,
    required super.size,
    super.priority,
  }) : assert(cellSize > 0) {
    paint.color = color;
  }

  /// The pixel size of each cell in the grid;
  final double cellSize;

  /// How many cells across this grid goes.
  int get gridWidth => width ~/ cellSize;

  /// How many cells tall this grid goes.
  int get gridHeight => height ~/ cellSize;

  @override
  void fuse() {
    for (var x = 0; x <= gridWidth; x += 1) {
      add(
        RectangleComponent(
          anchor: .center,
          position: Vector2(x * cellSize, gridHeight / 2 * cellSize),
          size: Vector2(2, gridHeight * cellSize + 1),
          paint: paint,
        ),
      );
    }

    for (var y = 0; y <= gridHeight; y += 1) {
      add(
        RectangleComponent(
          anchor: .center,
          position: Vector2(gridWidth / 2 * cellSize, y * cellSize),
          size: Vector2(gridWidth * cellSize + 1, 2),
          paint: paint,
        ),
      );
    }
  }
}
