import 'package:flutter_hooks/flutter_hooks.dart';

bool usePreviousChanged<T>(T value) {
  final previous = usePrevious(value) ?? value;
  return value != previous;
}
