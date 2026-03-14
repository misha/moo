import 'package:flutter/material.dart';

import 'package:moo/design/palette.dart';
import 'package:moo/gen/fonts.gen.dart';

final class Typography {
  const Typography._();

  //
  // VT323
  //

  static const headline = TextStyle(
    fontFamily: FontFamily.vt323,
    fontSize: 60,
    color: Palette.blood,
    height: 1.0,
    letterSpacing: 6,
    shadows: [
      Shadow(
        color: Palette.blood,
        blurRadius: 20,
      ),
    ],
  );

  static const commendation = TextStyle(
    fontFamily: FontFamily.vt323,
    fontSize: 60,
    color: Palette.neon,
    height: 1.0,
    letterSpacing: 6,
    shadows: [
      Shadow(
        color: Palette.neon,
        blurRadius: 20,
      ),
    ],
  );

  static const briefing = TextStyle(
    fontFamily: FontFamily.vt323,
    fontSize: 32,
    color: Palette.amber,
    height: 1.0,
    letterSpacing: 6,
    shadows: [
      Shadow(
        color: Palette.amber,
        blurRadius: 16,
      ),
    ],
  );

  static const surveillance = TextStyle(
    fontFamily: FontFamily.vt323,
    fontSize: 16,
    color: Palette.blood,
    letterSpacing: 2,
    height: 1.0,
  );

  static const button = TextStyle(
    fontFamily: FontFamily.vt323,
    fontSize: 24,
  );

  //
  // ShareTechMono
  //

  static const body = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    height: 1.2,
    color: Palette.terminal,
    fontSize: 16,
  );

  static const decor = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    height: 1.2,
    color: Palette.system,
    fontSize: 13,
    letterSpacing: 1.5,
  );

  static const input = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    color: Palette.neon,
    fontSize: 20,
    letterSpacing: 2,
  );

  static const special = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    color: Palette.amber,
    fontSize: 15,
    letterSpacing: 2,
  );

  static const alert = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    color: Palette.blood,
    fontSize: 15,
    letterSpacing: 2,
  );

  static const data = TextStyle(
    fontFamily: FontFamily.shareTechMono,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );
}
