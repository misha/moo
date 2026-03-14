import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/design.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/extension_icon_component.dart';
import 'package:moo/flame/fuses/fuse_file_system.dart';
import 'package:moo/flame/mixins/decoratable.dart';

class DirectoryComponent extends RectangleComponent with Fuse, Decoratable {
  DirectoryComponent(
    this.directory, {
    super.anchor,
    super.position,
    super.priority,
  }) : super(size: Vector2(165, 70));

  final Directory directory;

  @override
  void fuse() {
    add(RectangleHitbox(collisionType: .passive, isSolid: true));

    add(
      EmojiIconComponent(
        type: directory.type,
        position: Vector2(12, 12),
        size: .all(32),
      ),
    );

    add(
      TextComponent(
        text: directory.type.directory,
        position: Vector2(60, 10),
        textRenderer: TextPaint(
          style: Typography.data.copyWith(
            color: directory.type.color,
            fontSize: 18,
          ),
        ),
      ),
    );

    {
      final capacity = TextComponent(
        position: Vector2(60, 36),
        textRenderer: TextPaint(
          style: Typography.data.copyWith(
            color: directory.type.color,
            fontSize: 22,
          ),
        ),
      );

      fuseDirectoryWatcher(directory, (directory) {
        capacity.text = '${directory.size}/${directory.capacity}';
      });

      add(capacity);
    }

    {
      final barWidth = size.x - 8;
      final barY = size.y - 6;

      final background = RectangleComponent(
        position: Vector2(4, barY),
        size: Vector2(barWidth, 3),
        paint: Paint()..color = directory.type.color.withValues(alpha: 0.2),
      );

      final progress = RectangleComponent(
        position: Vector2(4, barY),
        size: .zero(),
        paint: Paint()..color = directory.type.color,
      );

      fuseDirectoryWatcher(directory, (directory) {
        progress.size.x = barWidth * directory.usage;
      });

      addAll([background, progress]);
    }

    fuseDirectoryWatcher(directory, (directory) {
      if (!directory.isFull) {
        return decorate(directory.type.color, alpha: 0.1);
      } else {
        return decorate(directory.type.color, alpha: 0.25);
      }
    });
  }
}
