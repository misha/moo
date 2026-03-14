import 'package:flame/extensions.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:moo/content.dart';
import 'package:moo/design.dart';
import 'package:moo/extension.dart';
import 'package:moo/game.dart';
import 'package:moo/hooks/use_previous_changed.dart';
import 'package:moo/hooks/use_state3.dart';

const _SIMPLE_TUTORIAL_LEVELS = 2;
const _ADVANCED_TUTORIAL_LEVELS = 5;

enum QuipSentiment { good, bad }

class BigBrother extends HookWidget {
  const BigBrother(this.game);

  final Game game;

  @override
  Widget build(BuildContext context) {
    final level = useListenableSelector(game, () => game.level);
    final score = useListenableSelector(game, () => game.score);
    final scoreChanged = usePreviousChanged(score);
    final errors = useListenableSelector(game, () => game.errors);
    final errorsChanged = usePreviousChanged(errors);

    String initialQuip() {
      if (level <= _SIMPLE_TUTORIAL_LEVELS) {
        return QUIP_TUTORIAL_SIMPLE.random();
      } else if (level <= _ADVANCED_TUTORIAL_LEVELS) {
        return QUIP_TUTORIAL_ADVANCED.random();
      } else {
        return 'EXECUTE FILING PROCEDURES.';
      }
    }

    final controller = useMemoized(() {
      return TypeWriterController(
        text: initialQuip(),
        duration: const Duration(milliseconds: 40),
      );
    }, [level]);

    useEffect(() => controller.dispose, [controller]);

    (String, QuipSentiment) nextQuip() {
      final quip = controller.value.text;

      if (level <= _SIMPLE_TUTORIAL_LEVELS) {
        return (QUIP_TUTORIAL_SIMPLE.randomOther(quip), .good);
      } else if (level <= _ADVANCED_TUTORIAL_LEVELS) {
        return (QUIP_TUTORIAL_ADVANCED.randomOther(quip), .good);
      } else if (scoreChanged) {
        return (QUIPS_GOOD.randomOther(quip), .good);
      } else {
        return (QUIPS_BAD.randomOther(quip), .bad);
      }
    }

    final (sentiment, _, setSentiment) = useState3(QuipSentiment.good);

    // Update the quip when score/error changes, but skip updates on level end.
    if ((scoreChanged || errorsChanged) && game.isPlaying) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final (quip, sentiment) = nextQuip();
        controller.value = .new([quip]);
        controller.resume(0);
        setSentiment(sentiment);
      });
    }

    return Column(
      crossAxisAlignment: .start,
      spacing: Space.x1,
      children: [
        Text('BB-7 BROADCAST', style: Typography.special.copyWith(fontSize: 12)),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: Space.p2,
                decoration: BoxDecoration(
                  border: .all(color: Palette.system),
                ),
                child: TypeWriter(
                  controller: controller,
                  builder: (_, value) {
                    return Text(
                      value.text,
                      textAlign: .start,
                      style: switch (sentiment) {
                        .good => Typography.special,
                        .bad => Typography.alert,
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
