import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/constants.dart';
import 'package:moo/gen/assets.gen.dart';

class SelectionBorderComponent extends SpriteAnimationComponent with Fuse {
  SelectionBorderComponent()
    : super(
        position: .all(-2),
        size: .all(CELL_SIZE + 2),
        priority: 1,
      );

  @override
  Future<void> fuse() async {
    final image = await Flame.images.load(Assets.images.select.path);
    final sheet = SpriteSheet(image: image, srcSize: .all(CELL_SIZE));
    animation = sheet.createAnimation(row: 0, stepTime: 0.05);
  }
}
