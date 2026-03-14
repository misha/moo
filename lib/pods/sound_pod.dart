import 'package:flame_audio/flame_audio.dart';
import 'package:moo/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moo/pods/settings_pod.dart';

part 'sound_pod.g.dart';

@Riverpod(keepAlive: true, dependencies: [settings])
class Sound extends _$Sound {
  final _log = makeLog('SOUND');

  @override
  void build() {
    // No state.
  }

  void play(String sound) {
    if (ref.read(settingsPod).sound) {
      FlameAudio.play(sound);
      _log.i('Played sound "${sound.split('/').last}".');
    }
  }
}
