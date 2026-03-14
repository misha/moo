import 'package:flutter/services.dart';

final _SHIFT_KEYS = Set.unmodifiable({
  LogicalKeyboardKey.shiftLeft,
  LogicalKeyboardKey.shiftRight,
});

bool isShiftPressed() {
  final pressed = HardwareKeyboard.instance.logicalKeysPressed;
  return pressed.intersection(_SHIFT_KEYS).isNotEmpty;
}
