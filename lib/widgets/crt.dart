import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moo/design.dart';
import 'package:moo/pods/settings_pod.dart';

class Crt extends HookConsumerWidget {
  const Crt({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(context, ref) {
    final scanlinesEnabled = ref.watch(settingsPod.select((settings) => settings.scanlines));

    return Stack(
      fit: .expand,
      children: [
        const ColoredBox(color: Palette.screen),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: .center,
              radius: 1.25,
              colors: [Colors.transparent, Colors.black87],
              stops: [0.1, 1.0],
            ),
          ),
        ),
        child,
        if (scanlinesEnabled)
          IgnorePointer(
            child: GameWidget(
              game: _CrtGame(),
            ),
          ),
      ],
    );
  }
}

class _CrtGame extends FlameGame with HasPaint {
  static const _SPACING = 4.0;
  static const _HEIGHT = 2.0;
  static const _SPEED = 20.0;

  double _offset = 0;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  void onLoad() {
    paint.color = Palette.scan;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _offset = (_offset + _SPEED * dt) % _SPACING;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final width = camera.viewport.size.x;
    final height = camera.viewport.size.y;

    for (double y = -_SPACING + _offset; y < height; y += _SPACING) {
      canvas.drawRect(.fromLTWH(0, y, width, _HEIGHT), paint);
    }
  }
}
