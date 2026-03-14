import 'dart:math';

/// Base points awarded per level.
const _POINTS_PER_LEVEL = 10;

/// Base points awarded per file archived.
const _POINTS_PER_FILE = 10;

/// Bonus multiplier (actually power) for batches.
const _POINT_BATCH_MULTIPLIER = 2;

/// Bonus multiplier for each remaining second in a level.
const _POINT_TIME_MULTIPLIER = 20;

final class Scoring {
  const Scoring._();

  static int computeFilingPoints({
    required int files,
  }) {
    assert(files >= 1);

    var points = files * _POINTS_PER_FILE;
    if (files > 1) points += pow(files, _POINT_BATCH_MULTIPLIER).round();
    return points;
  }

  static int computeLevelPoints({
    required int level,
  }) {
    assert(level >= 1);

    return level * _POINTS_PER_LEVEL;
  }

  static int computeBonusPoints({
    required int level,
    required int secondsRemaining,
  }) {
    assert(level >= 1);
    assert(secondsRemaining >= 0);

    // Scale the multiplier up from 10% to 100% over the first 10 levels.
    // This avoids overly rewarding easy levels with high timers.
    final multiplier = _POINT_TIME_MULTIPLIER * (level / 10).clamp(0, 1);
    return secondsRemaining * multiplier.round();
  }
}

void main() {
  print('FILES | POINTS');
  print('----- | ------');

  for (var files = 1; files <= 10; files += 1) {
    final points = Scoring.computeFilingPoints(files: files);

    print(
      '${files.toString().padLeft(5)} '
      '| ${points.toString().padLeft(6)}',
    );
  }

  print('');
  print('LEVEL | POINTS | B@ 5s | B@10s | B@15s');
  print('----- | ------ | ----- | ----- | ------');

  for (var level = 1; level <= 20; level += 1) {
    final points = Scoring.computeLevelPoints(level: level);
    final b5 = Scoring.computeBonusPoints(level: level, secondsRemaining: 5);
    final b10 = Scoring.computeBonusPoints(level: level, secondsRemaining: 10);
    final b15 = Scoring.computeBonusPoints(level: level, secondsRemaining: 15);

    print(
      '${level.toString().padLeft(5)} '
      '| ${points.toString().padLeft(6)} '
      '| ${b5.toString().padLeft(5)} '
      '| ${b10.toString().padLeft(5)} '
      '| ${b15.toString().padLeft(5)}',
    );
  }
}
