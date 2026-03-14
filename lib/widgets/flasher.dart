import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/design.dart';
import 'package:moo/pods/flash_pod.dart';

class Flasher extends HookConsumerWidget {
  const Flasher({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(context, ref) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 300));
    final flash = useAnimation(controller);

    ref.listen(flashPod, (_, _) {
      controller.forward(from: 0);
    });

    return Stack(
      fit: .expand,
      children: [
        child,
        if (flash > 0)
          IgnorePointer(
            child: ColoredBox(
              color: Palette.blood.withValues(
                alpha: 0.3 * (1 - flash),
              ),
            ),
          ),
      ],
    );
  }
}
