import 'package:flame/components.dart';

import 'package:moo/design.dart';
import 'package:moo/flame/mixins/decoratable.dart';

class SelectionOverlayComponent extends RectangleComponent with Decoratable {
  SelectionOverlayComponent() : super(priority: 1);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    decorate(Palette.neon, alpha: 0.08);
  }
}
