import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    @Default(true) bool blinking,
    @Default(true) bool controls,
    @Default(true) bool music,
    @Default(true) bool scanlines,
    @Default(true) bool sound,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}
