import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/design.dart';
import 'package:moo/gen/assets.gen.dart';
import 'package:moo/hooks/use_state3.dart';
import 'package:moo/pods/sound_pod.dart';

enum TerminalButtonVariant {
  positive,
  negative,
}

class TerminalButton extends HookConsumerWidget {
  const TerminalButton({
    required this.variant,
    required this.label,
    this.disabled = false,
    required this.onPressed,
  });

  final TerminalButtonVariant variant;
  final String label;
  final bool disabled;
  final void Function() onPressed;

  @override
  Widget build(context, ref) {
    final (hovered, _, setHovered) = useState3(false);
    final baseColor = useMemoized(() {
      return switch (variant) {
        .positive => Palette.neon,
        .negative => Palette.blood,
      };
    }, [variant]);

    final backgroundColor = useMemoized(() {
      if (disabled) return baseColor.withValues(alpha: 0.15);
      if (hovered) return Palette.amber;
      return baseColor;
    }, [baseColor, hovered, disabled]);

    final textColor = useMemoized(() {
      if (disabled) return baseColor.withValues(alpha: 0.5);
      return Colors.black;
    }, [baseColor, disabled]);

    final onTap = useMemoized(() {
      if (disabled) return null;

      return () {
        ref.read(soundPod.notifier).play(Assets.sounds.buttonPress);
        onPressed();
      };
    }, [disabled]);

    return MouseRegion(
      cursor: disabled ? .defer : SystemMouseCursors.click,
      onEnter: (_) => setHovered(true),
      onExit: (_) => setHovered(false),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: backgroundColor,
          padding: const .symmetric(
            horizontal: Space.x5,
            vertical: Space.x2,
          ),
          child: Text(
            '➤ $label',
            style: Typography.button.copyWith(
              color: textColor,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}
