import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/design/palette.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/directory_component.dart';
import 'package:moo/flame/components/file_ghost_component.dart';
import 'package:moo/flame/extensions.dart';
import 'package:moo/flame/fuses/fuse_collision_effect.dart';

class SelectionGhostComponent extends PositionComponent with Fuse, CollisionCallbacks, FuseCollisions {
  SelectionGhostComponent({
    required this.origin,
    required this.selection,
    super.position,
  });

  final Selection selection;
  final Location origin;

  @override
  void fuse() {
    add(RectangleHitbox(collisionType: .active, size: .all(1)));

    addAll([
      for (final location in selection.locations) //
        FileGhostComponent(
          location: location,
          selection: selection,
          position: (location - origin).toVector2(),
        ),
    ]);

    fuseCollisionEffect<DirectoryComponent>((target) {
      return target.decorate(Palette.neon, alpha: 0.4);
    });
  }
}
