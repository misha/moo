import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/design.dart';
import 'package:moo/pods/music_pod.dart';
import 'package:moo/setup.dart';
import 'package:moo/theme.dart';
import 'package:moo/widgets/crt.dart';
import 'package:moo/widgets/terminal.dart';

import 'widgetbook.directories.g.dart';

void main() async {
  runApp(await setup(const MinistryWidgetbookApp()));
}

@App()
class MinistryWidgetbookApp extends HookConsumerWidget {
  const MinistryWidgetbookApp();

  @override
  Widget build(context, ref) {
    ref.watch(musicPod);

    return Widgetbook(
      home: const MinistryWidgetbookHome(),
      directories: directories,
      appBuilder: (context, story) {
        return ProviderScope(
          child: MaterialApp(
            title: 'Widgetbook',
            theme: makeTheme(),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Material(
                child: Crt(
                  child: Center(child: story),
                ),
              );
            },
          ),
        );
      },
      themeMode: .dark,
      darkTheme: makeTheme().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      addons: [InspectorAddon()],
    );
  }
}

class MinistryWidgetbookHome extends StatelessWidget {
  const MinistryWidgetbookHome();

  @override
  Widget build(context) {
    return Scaffold(
      body: Terminal(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('MINISTRY OF ORDER', style: Typography.headline),
            Space.h3,
            Text('THE WIDGETBOOK', style: Typography.briefing),
            Space.h4,
            Text('WRITE CODE · TEST VARIABLES · SHIP GAMES', style: Typography.special),
          ],
        ),
      ),
    );
  }
}
