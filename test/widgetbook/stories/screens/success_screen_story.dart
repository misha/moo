import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/game.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/result.dart';
import 'package:moo/screens/success_screen.dart';
import 'package:moo/widgets/terminal.dart';

@UseCase(name: 'Default', type: SuccessScreen)
Widget buildSuccessScreenStory(BuildContext context) {
  final score = context.knobs.int.slider(
    label: 'Score',
    min: 0,
    max: 10000,
    initialValue: 2500,
  );

  final reward = context.knobs.int.slider(
    label: 'Reward',
    min: 0,
    max: 1000,
    initialValue: 500,
  );

  return HookBuilder(
    builder: (context) {
      final game = useMemoized(
        () => Game.raw(
          score: score,
          result: Win(reward: reward),
        ),
        [score, reward],
      );

      return ProviderScope(
        overrides: [
          gamePod.overrideWithValue(game),
        ],
        child: const Terminal(
          child: SuccessScreen(),
        ),
      );
    },
  );
}
