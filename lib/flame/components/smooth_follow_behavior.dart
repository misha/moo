import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

/// A behavior that lerps between the [source] and [target] with a given [speed].
///
/// If [snap] is true, mounting the behavior triggers a one-time direct update.
class SmoothFollowBehavior extends PositionComponent with Fuse {
  SmoothFollowBehavior({
    required this.source,
    required this.target,
    this.speed = 25.0,
    this.snap = false,
  });

  final Vector2 source;
  final Vector2 target;
  final double speed;
  final bool snap;

  @override
  void fuse() {
    fuseMount(() {
      if (snap) source.setFrom(target);
    });

    fuseUpdate((dt) {
      source.lerp(target, (dt * speed).clamp(0.0, 1.0));
    });
  }
}
