import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/hooks/use_state3.dart';
import 'package:moo/widgets/terminal_checkbox.dart';

@UseCase(name: 'Default', type: TerminalCheckbox)
Widget buildTerminalCheckboxStory(BuildContext context) {
  final disabled = context.knobs.boolean(label: 'Disabled');

  return HookBuilder(
    builder: (context) {
      final (accepted, _, setAccepted) = useState3(false);

      return TerminalCheckbox(
        label: 'ACCEPT TERMS OF COMPLIANCE',
        disabled: disabled,
        value: accepted,
        onChanged: setAccepted,
      );
    },
  );
}
