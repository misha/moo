// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  blinking: json['blinking'] as bool? ?? true,
  controls: json['controls'] as bool? ?? true,
  music: json['music'] as bool? ?? true,
  scanlines: json['scanlines'] as bool? ?? true,
  sound: json['sound'] as bool? ?? true,
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'blinking': instance.blinking,
  'controls': instance.controls,
  'music': instance.music,
  'scanlines': instance.scanlines,
  'sound': instance.sound,
};
