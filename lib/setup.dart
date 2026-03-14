import 'package:flutter/widgets.dart';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:moo/pods/package_info_pod.dart';
import 'package:moo/pods/preferences_pod.dart';

Future<Widget> setup(Widget child) async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.assets.prefix = '';
  Flame.images.prefix = '';
  FlameAudio.updatePrefix('');

  final packageInfo = await PackageInfo.fromPlatform();
  final preferences = await SharedPreferencesWithCache.create(cacheOptions: .new());

  return ProviderScope(
    overrides: [
      packageInfoPod.overrideWithValue(packageInfo),
      preferencesPod.overrideWithValue(preferences),
    ],
    child: child,
  );
}
