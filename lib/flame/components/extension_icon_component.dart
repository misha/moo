import 'package:flame/components.dart';

import 'package:moo/fs/objects/file_type.dart';

class EmojiIconComponent extends SpriteComponent {
  EmojiIconComponent({
    required this.type,
    super.anchor,
    super.position,
    super.size,
  });

  final FileType type;

  @override
  Future<void> onLoad() async {
    sprite = await .load(type.asset.path);
  }
}
