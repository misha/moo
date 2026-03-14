import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/constants.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/file_component.dart';
import 'package:moo/flame/extensions.dart';
import 'package:moo/flame/fuses/fuse_file_system.dart';
import 'package:moo/flame/mixins/decoratable.dart';
import 'package:moo/flame/mixins/dimmable.dart';

class LocationComponent extends RectangleComponent with Fuse, Dimmable, Decoratable {
  static LocationComponent find(FlameGame game, Location location) => //
      game.findByKeyName(location.toString())!;

  LocationComponent({
    required this.location,
  }) : super(
         key: .named(location.toString()),
         position: location.toVector2() + .all(1),
         size: .all(CELL_SIZE - 2),
       );

  final Location location;

  @override
  void fuse() {
    add(RectangleHitbox(collisionType: .passive, isSolid: true));

    fuseLocationWatcher(location, (file) {
      if (file != null) {
        final handle = FileComponent(file: file);
        add(handle);
        return handle.removeFromParent;
      }
    });

    fuseLocationWatcher(location, (file) {
      if (file != null) {
        return decorate(file.type.color, alpha: 1 / 8);
      }
    });
  }
}
