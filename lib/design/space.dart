import 'package:flutter/widgets.dart';

final class Space {
  const Space._();

  static const x1 = 5.0;
  static const x2 = x1 * 2;
  static const x3 = x1 * 3;
  static const x4 = x1 * 4;
  static const x5 = x1 * 5;

  static const h1 = SizedBox(height: x1);
  static const h2 = SizedBox(height: x2);
  static const h3 = SizedBox(height: x3);
  static const h4 = SizedBox(height: x4);
  static const h5 = SizedBox(height: x5);

  static const w1 = SizedBox(width: x1);
  static const w2 = SizedBox(width: x2);
  static const w3 = SizedBox(width: x3);
  static const w4 = SizedBox(width: x4);
  static const w5 = SizedBox(width: x5);

  static const p1 = EdgeInsets.all(x1);
  static const p2 = EdgeInsets.all(x2);
  static const p3 = EdgeInsets.all(x3);
  static const p4 = EdgeInsets.all(x4);
  static const p5 = EdgeInsets.all(x5);
}
