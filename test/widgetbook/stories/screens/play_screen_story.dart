import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/game.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/screens/play_screen.dart';
import 'package:moo/widgets/terminal.dart';

@UseCase(name: 'Default', type: PlayScreen)
Widget buildPlayScreenStory(BuildContext context) {
  final level = context.knobs.int.slider(
    label: 'Level',
    min: 1,
    max: 20,
    initialValue: 1,
    divisions: 20 - 1,
  );

  return HookBuilder(builder: (context) {
    final game = useMemoized(() => Game(level: level), [level]);

    return ProviderScope(
      overrides: [
        gamePod.overrideWithValue(game),
      ],
      child: const Terminal(
        child: PlayScreen(),
      ),
    );
  });
}
