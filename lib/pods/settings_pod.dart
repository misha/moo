import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moo/log.dart';
import 'package:moo/pods/preferences_pod.dart';
import 'package:moo/preferences.dart';
import 'package:moo/settings.dart';

part 'settings_pod.g.dart';

@Riverpod(dependencies: [preferences])
class SettingsManager extends _$SettingsManager {
  final _log = makeLog('SETTINGS');

  @override
  Settings build() {
    var settings = const Settings();

    try {
      final data = ref.read(preferencesPod).getString(PREFERENCE_SETTINGS);

      if (data != null) {
        final json = jsonDecode(data);
        settings = Settings.fromJson(json);
        _log.i('Loaded settings.');
      } else {
        _log.i('Applying initial settings.');
      }
    } catch (error, stackTrace) {
      _log.e('Failed to load settings.', error: error, stackTrace: stackTrace);
    }

    return settings;
  }

  Future<void> _save() async {
    final data = jsonEncode(state.toJson());
    await ref.read(preferencesPod).setString(PREFERENCE_SETTINGS, data);
  }

  void setBlinking(bool blinking) {
    state = state.copyWith(blinking: blinking);
    _log.i('Set blinking to $blinking.');
    _save();
  }

  void setControls(bool controls) {
    state = state.copyWith(controls: controls);
    _log.i('Set controls to $controls.');
    _save();
  }

  void setMusic(bool music) {
    state = state.copyWith(music: music);
    _log.i('Set music to $music.');
    _save();
  }

  void setScanlines(bool scanlines) {
    state = state.copyWith(scanlines: scanlines);
    _log.i('Set scanlines to $scanlines.');
    _save();
  }

  void setSound(bool sound) {
    state = state.copyWith(sound: sound);
    _log.i('Set sound to $sound.');
    _save();
  }
}

@Riverpod(dependencies: [SettingsManager])
Settings settings(Ref ref) => ref.watch(settingsManagerPod);
