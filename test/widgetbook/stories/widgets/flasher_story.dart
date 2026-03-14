import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/pods/flash_pod.dart';
import 'package:moo/widgets/flasher.dart';
import 'package:moo/widgets/terminal_button.dart';

@UseCase(name: 'Default', type: Flasher)
Widget buildFlasherStory(BuildContext context) {
  return ProviderScope(
    child: Consumer(
      builder: (context, ref, _) {
        return Flasher(
          child: Center(
            child: TerminalButton(
              variant: .negative,
              label: 'TRIGGER',
              onPressed: () => ref.read(flashPod.notifier).trigger(),
            ),
          ),
        );
      },
    ),
  );
}
