import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:moo/gen/assets.gen.dart';
import 'package:moo/gen/fonts.gen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_pod.g.dart';

@riverpod
class Loading extends _$Loading {
  @override
  double build() {
    _load();
    return 0;
  }

  Future<void> _load() async {
    const FONTS = [FontFamily.vt323, FontFamily.shareTechMono];

    var tasks = 0;
    tasks += FONTS.length;
    tasks += Assets.images.values.length;
    tasks += Assets.sounds.values.length;
    final step = 1 / tasks;

    // Run serially to spend non-zero time on the loading screen.

    for (final font in FONTS) {
      await FontLoader(font).load();
      state += step;
    }

    for (final image in Assets.images.values) {
      await Flame.images.load(image.path);
      state += step;
    }

    for (final sound in Assets.sounds.values) {
      await FlameAudio.audioCache.load(sound);
      state += step;
    }

    state = 1;
  }
}
