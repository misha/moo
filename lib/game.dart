import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:moo/constants.dart';
import 'package:moo/exercise.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/procgen.dart';
import 'package:moo/result.dart';
import 'package:moo/scoring.dart';

/// TODO: Rewrite into a state machine.
class Game with ChangeNotifier {
  Game({
    int level = 1,
    int? seed,
  }) {
    _procgen = Procgen(seed: seed);
    _level = level;
    _generate();
  }

  @visibleForTesting
  Game.raw({
    int level = 1,
    int score = 0,
    int? save = 0,
    int files = 0,
    int errors = 0,
    Duration? timer,
    Result? result,
    FileSystem? fs,
    int? seed,
  }) {
    _level = level;
    _score = score;
    _save = save ?? score;
    _archived = files;
    _errors = errors;
    _result = result;
    _procgen = Procgen(seed: seed);
    _exercise = Exercise.forLevel(level);
    _fs = fs ?? _exercise.build(_procgen);
    _timePermitted = timer ?? _timePermitted;
  }

  void _generate() {
    _exercise = Exercise.forLevel(_level);
    _fs = _exercise.build(_procgen);
    _timePermitted = _exercise.timer;
    _timeElapsed = .zero;
    _result = null;
    _save = _score;
  }

  int _level = 1;
  int _score = 0;
  int _save = 0;
  int _archived = 0;
  int _errors = 0;
  Duration _timePermitted = .zero;
  Duration _timeElapsed = .zero;
  Result? _result;

  late final Procgen _procgen;
  late Exercise _exercise;
  late FileSystem _fs;

  int get level => _level;
  int get score => _score;
  int get archived => _archived;
  int get errors => _errors;
  Duration get timePermitted => _timePermitted;
  Duration get timeElapsed => _timeElapsed;
  Result? get result => _result;
  bool get isPlaying => _result == null;
  bool get isDone => _result != null;

  Exercise get exercise => _exercise;
  FileSystem get fs => _fs;

  /// Attempts to archive all files specified by [selection] into [directory].
  void archive(Selection selection, Directory directory) {
    if (selection.isEmpty) return;

    final files = selection.locations
        .map(fs.contents) //
        .nonNulls
        .toList();

    final legal = files
        .map((file) => file.type) //
        .every((type) => type == directory.type);

    if (legal) {
      for (final file in files) {
        fs.archiveFile(file, directory);
      }

      _archived += selection.length;
      _score += Scoring.computeFilingPoints(files: selection.length);

      if (fs.isEmpty) {
        final base = Scoring.computeLevelPoints(level: level);
        final secondsRemaining = (timePermitted - timeElapsed).inSeconds;
        final bonus = Scoring.computeBonusPoints(level: level, secondsRemaining: secondsRemaining);
        _result = Win(reward: base + bonus);
      }
    } else {
      _errors += 1;

      if (errors >= MAX_ERRORS) {
        _result = const Lose(reason: .error);
      }
    }

    notifyListeners();
  }

  void tick(double dt) {
    if (!isPlaying) return;
    _timeElapsed += Duration(milliseconds: (dt * 1000).round());

    if (timeElapsed >= timePermitted) {
      _result = const Lose(reason: .time);
    }

    notifyListeners();
  }

  void next() {
    final result = _result;

    if (result is Win) {
      _score += result.reward;
    }

    _level += 1;
    _generate();
    notifyListeners();
  }

  void redo() {
    _score = max(0, _save - REDO_COST);
    _errors = 0;
    _generate();
    // Give a little slack on redo.
    _timePermitted += Duration(seconds: 3);
    notifyListeners();
  }

  void reset() {
    _level = 1;
    _score = 0;
    _archived = 0;
    _errors = 0;
    _generate();
    notifyListeners();
  }
}
