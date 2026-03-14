import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/constants.dart';
import 'package:moo/design/palette.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/extension_icon_component.dart';
import 'package:moo/flame/components/location_component.dart';
import 'package:moo/flame/fuses/fuse_collision_effect.dart';
import 'package:moo/flame/fuses/fuse_file_system.dart';
import 'package:moo/flame/mixins/decoratable.dart';

class FileGhostComponent extends RectangleComponent with Fuse, CollisionCallbacks, FuseCollisions, Decoratable {
  FileGhostComponent({
    required this.location,
    this.selection,
    super.position,
  }) : super(
         anchor: .center,
         size: .all(CELL_SIZE / 2),
       );

  final Location location;
  final Selection? selection;

  @override
  void fuse() {
    final game = fuseGame();
    final fs = fuseFileSystem();
    final file = fs.contents(location)!;
    decorate(file.type.color);

    add(
      RectangleHitbox(
        anchor: .center,
        collisionType: .active,
        position: size / 2,
        size: .all(1),
      ),
    );

    add(
      EmojiIconComponent(
        type: file.type,
        anchor: .center,
        position: size / 2,
        size: .all(24),
      ),
    );

    // Dim the source location while this ghost is alive.
    {
      final source = LocationComponent.find(game, location);
      source.dim(0.3);
      fuseRemove(source.undim);
    }

    fuseCollisionEffect<LocationComponent>((target) {
      final cohort = selection?.locations ?? const {};

      // There's only one situation in which we decorate intersected locations red,
      // but it's fairly complicated. The requirements are, in code order:
      //
      //  1. There is a selection with more than 1 file.
      //  2. The intersected location is not in the selection.
      //  3. There is something already in the intersected location.
      //
      // In this situation, a drop will fail to move the selection, so we use red.
      if (cohort.length > 1 && //
          !cohort.contains(target.location) &&
          fs.hasContents(target.location)) {
        return target.decorate(Palette.blood);
      } else {
        // In all other situations, dropping at any location always succeeds.
        // (Dropping single files on non-empty locations simply swaps them.)
        return target.decorate(Palette.neon);
      }
    });
  }
}
