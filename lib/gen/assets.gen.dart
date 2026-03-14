// dart format width=120

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ext_arc.png
  AssetGenImage get extArc => const AssetGenImage('assets/images/ext_arc.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_bio.png
  AssetGenImage get extBio => const AssetGenImage('assets/images/ext_bio.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_cal.png
  AssetGenImage get extCal => const AssetGenImage('assets/images/ext_cal.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_fin.png
  AssetGenImage get extFin => const AssetGenImage('assets/images/ext_fin.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_frm.png
  AssetGenImage get extFrm => const AssetGenImage('assets/images/ext_frm.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_pid.png
  AssetGenImage get extPid => const AssetGenImage('assets/images/ext_pid.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_pwd.png
  AssetGenImage get extPwd => const AssetGenImage('assets/images/ext_pwd.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_rpt.png
  AssetGenImage get extRpt => const AssetGenImage('assets/images/ext_rpt.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_sec.png
  AssetGenImage get extSec => const AssetGenImage('assets/images/ext_sec.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/ext_wep.png
  AssetGenImage get extWep => const AssetGenImage('assets/images/ext_wep.png', size: const Size(128.0, 128.0));

  /// File path: assets/images/select.png
  AssetGenImage get select => const AssetGenImage('assets/images/select.png', size: const Size(640.0, 64.0));

  /// List of all assets
  List<AssetGenImage> get values => [
    extArc,
    extBio,
    extCal,
    extFin,
    extFrm,
    extPid,
    extPwd,
    extRpt,
    extSec,
    extWep,
    select,
  ];
}

class $AssetsMusicGen {
  const $AssetsMusicGen();

  /// File path: assets/music/gloomy_factory.ogg
  String get gloomyFactory => 'assets/music/gloomy_factory.ogg';

  /// List of all assets
  List<String> get values => [gloomyFactory];
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/button_press.wav
  String get buttonPress => 'assets/sounds/button_press.wav';

  /// File path: assets/sounds/feedback_complete.wav
  String get feedbackComplete => 'assets/sounds/feedback_complete.wav';

  /// File path: assets/sounds/feedback_correct.wav
  String get feedbackCorrect => 'assets/sounds/feedback_correct.wav';

  /// File path: assets/sounds/feedback_incorrect.wav
  String get feedbackIncorrect => 'assets/sounds/feedback_incorrect.wav';

  /// List of all assets
  List<String> get values => [buttonPress, feedbackComplete, feedbackCorrect, feedbackIncorrect];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMusicGen music = $AssetsMusicGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({required this.isAnimation, required this.duration, required this.frames});

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
