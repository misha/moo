import 'package:flame/components.dart';
import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/extension_icon_component.dart';

class FileComponent extends PositionComponent with Fuse {
  FileComponent({
    required this.file,
  }) : super(size: .all(CELL_SIZE - 2));

  final File file;

  @override
  void fuse() {
    add(
      EmojiIconComponent(
        type: file.type,
        anchor: .bottomCenter,
        position: Vector2(size.x / 2, size.y / 2 + 6),
        size: .all(30),
      ),
    );

    add(
      TextComponent(
        text: file.type.label,
        anchor: .topCenter,
        position: Vector2(size.x / 2, size.y / 2 + 10),
        textRenderer: TextPaint(
          style: Typography.data.copyWith(
            color: file.type.color,
            fontSize: 14,
            fontWeight: .bold,
          ),
        ),
      ),
    );
  }
}
