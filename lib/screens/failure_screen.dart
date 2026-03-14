import 'package:flame/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/constants.dart';
import 'package:moo/content.dart';
import 'package:moo/design.dart';
import 'package:moo/high_score.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/pods/high_score_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/result.dart';
import 'package:moo/screens/login_screen.dart';
import 'package:moo/screens/play_screen.dart';
import 'package:moo/widgets/blinker.dart';
import 'package:moo/widgets/statistic_display.dart';
import 'package:moo/widgets/terminal_button.dart';

class FailureScreen extends HookConsumerWidget {
  const FailureScreen();

  @override
  Widget build(context, ref) {
    final game = ref.watch(gamePod);
    final lose = useMemoized(() => game.result as Lose);
    final quip = useMemoized(() => QUIPS_FAILURE.random());
    final beaten = useState(const <HighScoreField>{});

    useEffect(() {
      Future.microtask(() {
        beaten.value = ref
            .read(highScoreManagerPod.notifier) //
            .submit(
              score: game.score,
              level: game.level,
              files: game.archived,
            );
      });
    }, const []);

    return Column(
      mainAxisAlignment: .center,
      children: [
        Blinker(
          period: const Duration(seconds: 1),
          child: Text('⚠ CRITICAL COMPLIANCE FAILURE ⚠', style: Typography.alert),
        ),
        Space.h3,
        Text(
          switch (lose.reason) {
            .time => 'TEMPORAL INSUFFICIENCY',
            .error => 'EXCESSIVE MISFILING',
          },
          style: Typography.headline,
        ),
        Space.h3,
        Text(quip, style: Typography.special),
        Space.h5,
        StatisticTable(
          rows: [
            StatisticRow(
              label: 'EXERCISE',
              value: game.level,
              best: beaten.value.contains(HighScoreField.level),
            ),
            StatisticRow(
              label: 'FINAL RATING',
              value: game.score,
              best: beaten.value.contains(HighScoreField.score),
            ),
            StatisticRow(
              label: 'FILES ARCHIVED',
              value: game.archived,
              best: beaten.value.contains(HighScoreField.files),
            ),
          ],
        ),
        Space.h5,
        Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          spacing: Space.x5,
          children: [
            Column(
              children: [
                TerminalButton(
                  variant: .positive,
                  label: 'REMEDIATE',
                  onPressed: () {
                    game.redo();
                    ref.read(screenPod.notifier).go(const PlayScreen());
                  },
                ),
                Space.h2,
                Text('RETRY FOR $REDO_COST POINTS', style: Typography.special),
              ],
            ),
            TerminalButton(
              variant: .negative,
              label: 'LOGOUT',
              onPressed: () {
                game.reset();
                ref.read(screenPod.notifier).go(const LoginScreen());
              },
            ),
          ],
        ),
      ],
    );
  }
}
