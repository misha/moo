// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'high_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighScore _$HighScoreFromJson(Map<String, dynamic> json) => _HighScore(
  score: (json['score'] as num?)?.toInt() ?? 0,
  level: (json['level'] as num?)?.toInt() ?? 0,
  files: (json['files'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HighScoreToJson(_HighScore instance) =>
    <String, dynamic>{
      'score': instance.score,
      'level': instance.level,
      'files': instance.files,
    };
