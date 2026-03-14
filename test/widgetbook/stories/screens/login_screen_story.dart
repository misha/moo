import 'package:flutter/widgets.dart';
import 'package:moo/widgets/terminal.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/screens/login_screen.dart';

@UseCase(name: 'Default', type: LoginScreen)
Widget buildLoginScreenStory(_) {
  return const Terminal(
    child: LoginScreen(),
  );
}
