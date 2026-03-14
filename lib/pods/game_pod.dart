import 'package:moo/game.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_pod.g.dart';

@Riverpod(keepAlive: true)
Game game(Ref ref) => Game();
