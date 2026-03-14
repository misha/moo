import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/hooks/use_state3.dart';
import 'package:moo/pods/email_pod.dart';
import 'package:moo/pods/screen_pod.dart';
import 'package:moo/pods/package_info_pod.dart';
import 'package:moo/pods/settings_pod.dart';
import 'package:moo/screens/play_screen.dart';
import 'package:moo/widgets/terminal_button.dart';
import 'package:moo/widgets/terminal_checkbox.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen();

  @override
  Widget build(context, ref) {
    final packageInfo = ref.read(packageInfoPod);
    final controller = useTextEditingController(text: ref.read(emailPod));
    final (showError, _, setError) = useState3(false);

    final focusNode = useFocusNode();
    final focused = focusNode.hasFocus;
    useListenable(focusNode);

    useEffect(() {
      focusNode.requestFocus();
    }, []);

    final settings = ref.watch(settingsPod);

    void submit() {
      final email = controller.text.trim().toLowerCase();

      if (email.endsWith('@moo.gov') && EmailValidator.validate(email)) {
        setError(false);
        ref.read(emailPod.notifier).save(email.toUpperCase());
        ref.read(screenPod.notifier).go(const PlayScreen());
      } else {
        setError(true);
      }
    }

    return Column(
      mainAxisAlignment: .center,
      children: [
        Spacer(),
        Text('MINISTRY OF ORDER', style: Typography.headline),
        Space.h3,
        Text('OFFICER TRAINING PROGRAM', style: Typography.briefing),
        Space.h4,
        Text('SORT FILES · IMPROVE RATING · CONQUER CHAOS', style: Typography.special),
        Space.h5,
        SizedBox(
          width: TERMINAL_SIZE * 2 / 3,
          child: Column(
            children: [
              Container(
                padding: Space.p5,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  border: .all(color: Palette.terminal),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: Space.x2,
                  children: [
                    Text('OFFICER LOGIN', style: Typography.decor),
                    Container(
                      padding: Space.p2,
                      decoration: BoxDecoration(
                        border: .all(color: focused ? Palette.neon : Palette.system),
                      ),
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'CADET@MOO.GOV',
                          hintStyle: Typography.input.copyWith(color: Colors.white24),
                          hintMaxLines: null,
                        ),
                        style: Typography.input,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                          .withFunction((_, value) => value.copyWith(text: value.text.toUpperCase())),
                        ],
                        onChanged: (_) => setError(false),
                        onSubmitted: (_) => submit(),
                      ),
                    ),
                    if (showError) //
                      Row(
                        children: [
                          Text(
                            '⚠ ERROR: UNSANCTIONED EMAIL ADDRESS.\n'
                            'CONTACT ADMINISTRATOR FOR @MOO.GOV ACCOUNT.',
                            style: Typography.surveillance,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Space.h5,
              TerminalButton(
                variant: .positive,
                label: 'COMMENCE TRAINING',
                disabled: showError,
                onPressed: submit,
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: .center,
          spacing: Space.x3,
          children: [
            TerminalCheckbox(
              label: 'BLINKING',
              value: settings.blinking,
              onChanged: ref.read(settingsManagerPod.notifier).setBlinking,
            ),
            TerminalCheckbox(
              label: 'CONTROLS',
              value: settings.controls,
              onChanged: ref.read(settingsManagerPod.notifier).setControls,
            ),
            TerminalCheckbox(
              label: 'MUSIC',
              value: settings.music,
              onChanged: ref.read(settingsManagerPod.notifier).setMusic,
            ),
            TerminalCheckbox(
              label: 'SCANLINES',
              value: settings.scanlines,
              onChanged: ref.read(settingsManagerPod.notifier).setScanlines,
            ),
            TerminalCheckbox(
              label: 'SOUND',
              value: settings.sound,
              onChanged: ref.read(settingsManagerPod.notifier).setSound,
            ),
          ],
        ),
        Space.h5,
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('FLAME GAME JAM 2026', style: Typography.body),
            Text('A GAME BY MISHA SOLITERMAN', style: Typography.body),
          ],
        ),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('OS VER. ${packageInfo.version}', style: Typography.body),
            Text('MUSIC BY ERIC THE FUNNY BARON · SOUND BY SHAPEFORMS', style: Typography.body),
          ],
        ),
      ],
    );
  }
}
