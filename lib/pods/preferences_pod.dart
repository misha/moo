import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_pod.g.dart';

@riverpod
SharedPreferencesWithCache preferences(Ref ref) => throw StateError('Not loaded.');
