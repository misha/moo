import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moo/design.dart';
import 'package:moo/pods/loading_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/screens/login_screen.dart';

class LoadingScreen extends HookConsumerWidget {
  const LoadingScreen();

  @override
  Widget build(context, ref) {
    final progress = ref.watch(loadingPod);

    useEffect(() {
      if (progress >= 1.0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(screenPod.notifier).go(const LoginScreen());
        });
      }
    }, [progress]);

    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      spacing: Space.x3,
      children: [
        Text(
          'INITIALIZING OPERATING SYSTEM...',
          style: Typography.body,
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Palette.system,
          color: Palette.neon,
          minHeight: Space.x2,
        ),
      ],
    );
  }
}
