import 'package:flame/game.dart';

import 'package:moo/fs/file_system.dart';

mixin HasFileSystem on FlameGame {
  FileSystem get fs;
}
