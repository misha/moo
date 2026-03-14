import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:moo/design.dart';
import 'package:moo/hooks/use_state3.dart';

class TerminalCheckbox extends HookWidget {
  const TerminalCheckbox({
    required this.label,
    this.disabled = false,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool disabled;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(context) {
    final (hovered, _, setHovered) = useState3(false);

    final color = useMemoized(() {
      if (disabled) return Palette.blood.withValues(alpha: 0.2);

      final base = switch (value) {
        true => Palette.neon,
        false => Palette.blood,
      };

      if (hovered) return base;
      return base.withValues(alpha: 0.8);
    }, [hovered, value, disabled]);

    return MouseRegion(
      cursor: disabled ? .defer : SystemMouseCursors.click,
      onEnter: (_) => setHovered(true),
      onExit: (_) => setHovered(false),
      child: GestureDetector(
        onTap: disabled ? null : () => onChanged(!value),
        child: Text(
          '[${!disabled && value ? '✗' : ' '}] $label',
          style: Typography.button.copyWith(
            fontSize: 20,
            color: color,
          ),
        ),
      ),
    );
  }
}
