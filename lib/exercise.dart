import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:moo/constants.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/procgen.dart';

part 'exercise.freezed.dart';

@freezed
abstract class Exercise with _$Exercise {
  static Exercise forLevel(int level) {
    assert(level >= 1);

    // Ramp up system size, maxing out at level 10.
    final size = (4 + level ~/ 2).clamp(4, MAX_FS_SIZE);

    // Increase the number of file types every 4 levels.
    // Exercises with only one file type are trivially solvable, but likely
    // an important on-boarding step to learn the controls, directories, etc.
    const TUTORIAL_LEVELS = 2;
    final types = (1 + (level + (3 - TUTORIAL_LEVELS)) ~/ 4).clamp(1, 5);

    // Total file count always increases, but the file count per file type
    // may drop as a result of additional file types, creating a natural wave
    // pattern in that value.
    final files = (level * 3).clamp(2, types * 10);

    // Slowly increase the transformation count into infinity, but allow a
    // lull in progression when new file types are introduced.
    final transformations = 3 + level - types;

    // For the time limit, 20 seconds seems to be my absolute best performance.
    // Let it reach that, but not for quite some time; there's fun to be had.
    final timer = Duration(seconds: (50 - level - 1).round().clamp(20, 50));

    return Exercise(
      size: size,
      types: types,
      files: files,
      transformations: transformations,
      timer: timer,
    );
  }

  const Exercise._();

  const factory Exercise({
    required int size,
    required int types,
    required int files,
    required int transformations,
    required Duration timer,
  }) = _Exercise;

  int get filesPerExt => (files / types).round();

  FileSystem build(Procgen procgen) {
    return procgen.generate(
      types: types,
      filesPerType: filesPerExt,
      transformations: transformations,
      size: size,
    );
  }
}

void main() {
  print('LEVEL | TYPES | FILES | FPE | XFM | SIZE | TIME');
  print('----- | ----- | ----- | --- | --- | ---- | ----');

  for (var level = 1; level <= 20; level += 1) {
    final exercise = Exercise.forLevel(level);

    print(
      '${level.toString().padLeft(5)} '
      '| ${exercise.types.toString().padLeft(5)} '
      '| ${exercise.files.toString().padLeft(5)} '
      '| ${exercise.filesPerExt.toString().padLeft(3)} '
      '| ${exercise.transformations.toString().padLeft(3)} '
      '| ${exercise.size.toString().padLeft(4)} '
      '| ${exercise.timer.inSeconds}s',
    );
  }
}
