import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/big_brother.dart';
import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/flame/ministry_flame.dart';
import 'package:moo/gen/assets.gen.dart';
import 'package:moo/hooks/use_previous_changed.dart';
import 'package:moo/pods/flash_pod.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/pods/settings_pod.dart';
import 'package:moo/pods/sound_pod.dart';
import 'package:moo/result.dart';
import 'package:moo/screens/failure_screen.dart';
import 'package:moo/screens/success_screen.dart';
import 'package:moo/widgets/game_timer.dart';

class PlayScreen extends HookConsumerWidget {
  const PlayScreen();

  @override
  Widget build(context, ref) {
    final game = ref.watch(gamePod);
    final settings = ref.watch(settingsPod);
    final flame = useMemoized(() => MinistryFlame(game), [game]);
    final score = useListenableSelector(game, () => game.score);
    final scoreChanged = usePreviousChanged(score);
    final errors = useListenableSelector(game, () => game.errors);
    final errorsChanged = usePreviousChanged(errors);
    final result = useListenableSelector(game, () => game.result);

    // Positive feedback.
    if (scoreChanged) {
      ref.read(soundPod.notifier).play(Assets.sounds.feedbackCorrect);
    }

    // Negative feedback.
    if (errorsChanged) {
      Future.microtask(() => ref.read(flashPod.notifier).trigger());
      ref.read(soundPod.notifier).play(Assets.sounds.feedbackIncorrect);
    }

    if (result != null) {
      switch (result) {
        case Win():
          // Slightly delay transition to let the score animate.
          Future.delayed(const Duration(seconds: 1), () {
            ref.read(screenPod.notifier).go(const SuccessScreen());
          });

          // HACK: This sound effect triggers kind of slow... play it just
          //  before transitioning to the success screen. The real solution
          //  is to trim the sound file.
          Future.delayed(const Duration(milliseconds: 900), () {
            ref.read(soundPod.notifier).play(Assets.sounds.feedbackComplete);
          });

        case Lose():
          // Losing, however, can just happen immediately.
          Future.microtask(() {
            ref.read(screenPod.notifier).go(const FailureScreen());
          });
      }
    }

    return Stack(
      children: [
        Padding(
          padding: .symmetric(horizontal: Space.x2),
          child: Column(
            children: [
              Row(
                spacing: Space.x5,
                crossAxisAlignment: .center,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('EXERCISE', style: Typography.body.copyWith(fontSize: 21)),
                      Text('${game.level}', style: Typography.special.copyWith(fontSize: 25)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('RATING', style: Typography.body.copyWith(fontSize: 21)),
                      AnimatedFlipCounter(
                        value: score,
                        duration: const Duration(milliseconds: 500),
                        textStyle: Typography.special.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('ERRORS', style: Typography.body.copyWith(fontSize: 21)),
                      Text('$errors/$MAX_ERRORS', style: Typography.special.copyWith(fontSize: 25)),
                    ],
                  ),
                  Expanded(child: BigBrother(game)),
                ],
              ),
              Space.h3,
              GameTimer(game),
              Expanded(child: GameWidget(game: flame)),
            ],
          ),
        ),
        if (settings.controls)
          const Align(
            alignment: .bottomRight,
            child: IgnorePointer(
              child: Padding(
                padding: .only(right: Space.x1, bottom: Space.x1),
                child: DefaultTextStyle(
                  style: Typography.body,
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Text('----- CONTROLS -----'),
                      Space.h1,
                      Text("CLICK → DRAG'N'DROP"),
                      Text('DRAG  → AREA SELECT'),
                      Text('SHIFT → AREA SELECT'),
                      Text(''),
                      Text('----- DROPPING -----'),
                      Space.h1,
                      Text('OTHER FILE  → SWAP '),
                      Text('DIRECTORY   → SCORE'),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
