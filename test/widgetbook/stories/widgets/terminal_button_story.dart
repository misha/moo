import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/design.dart';
import 'package:moo/hooks/use_state3.dart';
import 'package:moo/widgets/terminal_button.dart';

@UseCase(name: 'Default', type: TerminalButton)
Widget buildTerminalButtonStory(BuildContext context) {
  return HookBuilder(
    builder: (_) {
      final variant = context.knobs.object.dropdown(
        label: 'Variant',
        options: TerminalButtonVariant.values,
        labelBuilder: (variant) => variant.name,
      );

      final disabled = context.knobs.boolean(label: 'Disabled');
      final (presses, _, setPressed) = useState3(0);

      return Column(
        mainAxisSize: .min,
        spacing: Space.x3,
        children: [
          TerminalButton(
            variant: variant,
            label: 'BUTTON',
            disabled: disabled,
            onPressed: () => setPressed(presses + 1),
          ),
          Text(
            'Pressed $presses times.',
            style: Typography.body,
          ),
        ],
      );
    },
  );
}
