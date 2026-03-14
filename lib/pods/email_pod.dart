import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moo/log.dart';
import 'package:moo/pods/preferences_pod.dart';
import 'package:moo/preferences.dart';

part 'email_pod.g.dart';

@Riverpod(dependencies: [preferences])
class Email extends _$Email {
  final _log = makeLog('EMAIL');

  @override
  String build() => ref.read(preferencesPod).getString(PREFERENCE_EMAIL) ?? 'CADET@MOO.GOV';

  void save(String email) async {
    if (state == email) return;
    await ref.read(preferencesPod).setString(PREFERENCE_EMAIL, email);
    _log.i('Updated email.');
  }
}
