import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/design.dart';
import 'package:moo/pods/music_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/setup.dart';
import 'package:moo/theme.dart';
import 'package:moo/widgets/flasher.dart';
import 'package:moo/widgets/terminal.dart';

void main() async {
  runApp(await setup(const MinistryApp()));
}

class MinistryApp extends HookConsumerWidget {
  const MinistryApp();

  @override
  Widget build(context, ref) {
    ref.watch(musicPod);

    return MaterialApp(
      home: Scaffold(
        body: Flasher(
          child: Terminal(
            child: ref.watch(screenPod),
          ),
        ),
      ),
      theme: makeTheme(),
    );
  }
}
