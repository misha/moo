import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moo/design.dart';

import 'package:moo/game.dart';

class GameTimer extends HookWidget {
  const GameTimer(this.game);

  final Game game;

  @override
  Widget build(context) {
    final progress = useListenableSelector(game, () {
      final elapsed = game.timeElapsed.inMilliseconds;
      final permitted = game.timePermitted.inMilliseconds;
      return 1.0 - (elapsed / permitted).clamp(0, 1);
    });

    final color = switch (progress) {
      >= 0.5 => Palette.neon,
      >= 0.25 => Palette.amber,
      _ => Palette.blood,
    };

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Palette.system,
      color: color,
      minHeight: Space.x2,
    );
  }
}
