import 'dart:ui';

import 'package:flame/components.dart';

mixin Dimmable on Component {
  final _paint = Paint();

  void dim(double opacity) {
    _paint.color = Color.fromRGBO(0, 0, 0, opacity);
  }

  void undim() {
    _paint.color = const Color.fromRGBO(0, 0, 0, 1);
  }

  @override
  void renderTree(Canvas canvas) {
    if (_paint.color.a < 1.0) {
      canvas.saveLayer(null, _paint);
      super.renderTree(canvas);
      canvas.restore();
    } else {
      super.renderTree(canvas);
    }
  }
}
