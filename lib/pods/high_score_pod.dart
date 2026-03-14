import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moo/high_score.dart';
import 'package:moo/log.dart';
import 'package:moo/pods/preferences_pod.dart';
import 'package:moo/preferences.dart';

part 'high_score_pod.g.dart';

@Riverpod(keepAlive: true, dependencies: [preferences])
class HighScoreManager extends _$HighScoreManager {
  HighScoreManager({
    this.base = const HighScore(),
    @visibleForTesting this.clear = false,
  });

  final HighScore base;
  final bool clear;

  final _log = makeLog('HIGHSCORE');

  @override
  HighScore build() {
    if (clear) {
      ref.read(preferencesPod).remove(PREFERENCE_HIGH_SCORE);
      return base;
    }

    try {
      final data = ref.read(preferencesPod).getString(PREFERENCE_HIGH_SCORE);

      if (data != null) {
        final highScore = HighScore.fromJson(jsonDecode(data));
        _log.i('Loaded high score.');
        return highScore;
      }
    } catch (error, stackTrace) {
      _log.e('Failed to load high score.', error: error, stackTrace: stackTrace);
    }

    return base;
  }

  Future<void> _save() async {
    final data = jsonEncode(state.toJson());
    await ref.read(preferencesPod).setString(PREFERENCE_HIGH_SCORE, data);
    _log.i('Updated high score.');
  }

  void reset() {
    state = const HighScore();
    _save();
  }

  Set<HighScoreField> submit({
    required int score,
    required int level,
    required int files,
  }) {
    final beaten = <HighScoreField>{};
    var updated = state;

    if (score > state.score) {
      updated = updated.copyWith(score: score);
      beaten.add(.score);
    }

    if (level > state.level) {
      updated = updated.copyWith(level: level);
      beaten.add(.level);
    }

    if (files > state.files) {
      updated = updated.copyWith(files: files);
      beaten.add(.files);
    }

    if (beaten.isNotEmpty) {
      _save();
      state = updated;
    }

    return beaten;
  }
}

@Riverpod(dependencies: [HighScoreManager])
HighScore highScore(Ref ref) => ref.watch(highScoreManagerPod);
