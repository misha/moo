import 'dart:math';

import 'package:flame/extensions.dart';

extension ListExtension<E> on List<E> {
  E randomOther(E anythingButThis, [Random? random]) {
    var choice = this.random(random);
    while (choice == anythingButThis) choice = this.random(random);
    return choice;
  }
}
