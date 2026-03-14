import 'package:flutter/material.dart';

import 'package:flame/components.dart';

class _Decoration {
  const _Decoration(this.color, this.alpha);

  final Color color;
  final double alpha;
}

mixin Decoratable on HasPaint {
  final _decorations = <_Decoration>[];

  Paint get fillPaint => paint;

  final borderPaint = Paint()
    ..color = Colors.transparent
    ..style = .stroke
    ..strokeWidth = 1.5;

  @override
  Future<void> onLoad() async {
    fillPaint.color = Colors.transparent;
    paintLayers = [fillPaint, borderPaint];
    await super.onLoad();
  }

  Function decorate(Color color, {double alpha = 0.25}) {
    final decoration = _Decoration(color, alpha);
    _decorations.add(decoration);
    _apply();

    return () {
      _decorations.remove(decoration);
      _apply();
    };
  }

  void _apply() {
    if (_decorations.isNotEmpty) {
      final top = _decorations.last;
      fillPaint.color = top.color.withValues(alpha: top.alpha);
      borderPaint.color = top.color;
    } else {
      fillPaint.color = Colors.transparent;
      borderPaint.color = Colors.transparent;
    }
  }
}
