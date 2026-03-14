import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/design.dart';
import 'package:moo/high_score.dart';
import 'package:moo/game.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/pods/high_score_pod.dart';
import 'package:moo/result.dart';
import 'package:moo/screens/failure_screen.dart';
import 'package:moo/widgets/terminal.dart';

@UseCase(name: 'Default', type: FailureScreen)
Widget buildFailureScreenStory(BuildContext context) {
  final currentLevel = context.knobs.int.slider(
    label: 'Current Level',
    initialValue: 5,
    min: 1,
    max: 10,
  );

  final currentScore = context.knobs.int.slider(
    label: 'Current Score',
    initialValue: 1200,
    min: 0,
    max: 10000,
  );

  final currentFiles = context.knobs.int.slider(
    label: 'Current Files',
    initialValue: 100,
    min: 0,
    max: 1000,
  );

  final loseReason = context.knobs.object.dropdown(
    label: 'Lose Reason',
    options: LoseReason.values,
    labelBuilder: (reason) => reason.name,
    initialOption: LoseReason.error,
  );

  final bestLevel = context.knobs.int.slider(
    label: 'Best Level',
    initialValue: 3,
    min: 0,
    max: 10,
  );

  final bestScore = context.knobs.int.slider(
    label: 'Best Score',
    initialValue: 1000,
    min: 0,
    max: 10000,
  );

  final bestFiles = context.knobs.int.slider(
    label: 'Best Files',
    initialValue: 99,
    min: 0,
    max: 1000,
  );

  return ProviderScope(
    overrides: [
      gamePod.overrideWithValue(
        Game.raw(
          level: currentLevel,
          score: currentScore,
          files: currentFiles,
          result: Lose(reason: loseReason),
        ),
      ),
      highScoreManagerPod.overrideWith(
        () => HighScoreManager(
          base: HighScore(
            level: bestLevel,
            score: bestScore,
            files: bestFiles,
          ),
          clear: true,
        ),
      ),
    ],
    child: const Terminal(
      child: FailureScreen(),
    ),
  );
}
