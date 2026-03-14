import 'package:flutter/widgets.dart';
import 'package:moo/pods/game_pod.dart';
import 'package:moo/screens/loading_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_pod.g.dart';

@Riverpod(keepAlive: true, dependencies: [game])
class Screen extends _$Screen {
  @override
  Widget build() => const LoadingScreen();

  void go(Widget screen) => state = screen;
}
