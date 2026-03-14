import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/design.dart';
import 'package:moo/widgets/terminal.dart';

@UseCase(name: 'Default', type: Terminal)
Widget buildTerminalStory(_) {
  return const Terminal(
    child: Center(
      child: Text(
        'CONTENT AREA',
        style: Typography.body,
      ),
    ),
  );
}
