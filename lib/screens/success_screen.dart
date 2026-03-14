import 'package:flame/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/content.dart';
import 'package:moo/design.dart';
import 'package:moo/hooks/use_state3.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/screens/play_screen.dart';
import 'package:moo/widgets/statistic_display.dart';
import 'package:moo/widgets/terminal_button.dart';

class SuccessScreen extends HookConsumerWidget {
  const SuccessScreen();

  @override
  Widget build(context, ref) {
    final game = ref.watch(gamePod);
    final (isReady, _, setReady) = useState3(false);
    final quip = useMemoized(() => QUIPS_SUCCESS.random());

    // HACK: I put the bonus scoring in `next()` so I could animate it here. But it ALSO
    //  animates from the previous level to the next one. So yeah, bad abstraction. Cheat
    //  and just keep the original level around, instead of actually fixing it.
    final level = useMemoized(() => game.level);
    useListenable(game);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 250)).then((_) {
        game.next();

        // Wait for the score to stop animating.
        Future.delayed(const Duration(milliseconds: 500), () {
          setReady(true);
        });
      });
    }, const []);

    return Column(
      mainAxisAlignment: .center,
      spacing: Space.x5,
      children: [
        Text('EXERCISE $level COMPLETE', style: Typography.special),
        Text('ACCEPTABLE PERFORMANCE', style: Typography.commendation),
        Text(quip, style: Typography.special),
        StatisticTable(
          rows: [
            StatisticRow(label: 'CURRENT RATING', value: game.score),
            StatisticRow(label: 'FILES ARCHIVED', value: game.archived),
          ],
        ),
        TerminalButton(
          variant: .positive,
          label: 'NEXT EXERCISE',
          disabled: !isReady,
          onPressed: () => ref
              .read(screenPod.notifier) //
              .go(const PlayScreen()),
        ),
      ],
    );
  }
}
