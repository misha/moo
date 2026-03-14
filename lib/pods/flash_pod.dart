import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flash_pod.g.dart';

@Riverpod(keepAlive: true)
class Flash extends _$Flash {
  @override
  int build() => 0;

  void trigger() => state += 1;
}
