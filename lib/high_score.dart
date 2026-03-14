import 'package:freezed_annotation/freezed_annotation.dart';

part 'high_score.freezed.dart';
part 'high_score.g.dart';

enum HighScoreField {
  score,
  level,
  files,
}

@freezed
abstract class HighScore with _$HighScore {
  const factory HighScore({
    @Default(0) int score,
    @Default(0) int level,
    @Default(0) int files,
  }) = _HighScore;

  factory HighScore.fromJson(Map<String, dynamic> json) => _$HighScoreFromJson(json);
}
