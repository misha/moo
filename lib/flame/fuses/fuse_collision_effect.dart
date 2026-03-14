import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

/// Calls [apply] when this component collides with a component of type [T].
///
/// The returned cleanup function is then called automatically when collision ends.
void fuseCollisionEffect<T extends PositionComponent>(Function? Function(T target) apply) {
  final cleanups = <T, Function>{};

  fuseCollisionStart<T>((target) {
    final cleanup = apply(target);
    if (cleanup != null) cleanups[target] = cleanup;
  });

  fuseCollisionEnd<T>((target) {
    cleanups.remove(target)?.call();
  });
}
