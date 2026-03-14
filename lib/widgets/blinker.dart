import 'package:flutter/widgets.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/hooks/use_blinker.dart';
import 'package:moo/pods/settings_pod.dart';

class Blinker extends HookConsumerWidget {
  const Blinker({
    required this.period,
    required this.child,
  });

  final Duration period;
  final Widget child;

  @override
  Widget build(context, ref) {
    final enabled = ref.watch(settingsPod.select((settings) => settings.blinking));
    final blinker = useBlinker(period);

    if (!enabled) {
      return child;
    }

    return AnimatedOpacity(
      opacity: blinker ? 1 : 0,
      duration: const Duration(milliseconds: 50),
      child: child,
    );
  }
}
