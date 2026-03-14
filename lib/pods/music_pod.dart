import 'package:flame_audio/flame_audio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moo/gen/assets.gen.dart';
import 'package:moo/log.dart';
import 'package:moo/pods/settings_pod.dart';

part 'music_pod.g.dart';

final _LOG = makeLog('MUSIC');

@Riverpod(dependencies: [settings])
void music(Ref ref) async {
  final enabled = ref.watch(settingsPod.select((settings) => settings.music));

  if (enabled) {
    await FlameAudio.bgm.play(Assets.music.gloomyFactory, volume: 0.5);
    _LOG.i('Started background music.');

    ref.onDispose(() async {
      await FlameAudio.bgm.stop();
      _LOG.i('Stopped background music');
    });
  }
}
