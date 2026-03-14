import 'package:flame/game.dart';
import 'package:moo/flame/components/grid_component.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/constants.dart';
import 'package:moo/design.dart';

@UseCase(name: 'Default', type: GridComponent)
Widget buildGridComponentStory(BuildContext context) {
  final gridSize = context.knobs.int.slider(
    label: 'Grid Size',
    min: 1,
    max: 10,
    initialValue: 5,
    divisions: 10 - 1,
  );

  final (_, gridColor) = context.knobs.object.dropdown(
    label: 'Grid Color',
    options: [
      ('system', Palette.system),
      ('phosphor', Palette.phosphor),
    ],
    labelBuilder: (entry) => entry.$1,
  );

  return GameWidget(
    game: _StoryGame(
      gridSize: .all(gridSize * CELL_SIZE),
      gridColor: gridColor,
    ),
  );
}

class _StoryGame extends FlameGame {
  _StoryGame({
    required this.gridSize,
    required this.gridColor,
  });

  final Vector2 gridSize;
  final Color gridColor;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  void onLoad() {
    world.add(
      GridComponent(
        anchor: .center,
        cellSize: CELL_SIZE,
        color: gridColor,
        size: gridSize,
      ),
    );
  }
}
