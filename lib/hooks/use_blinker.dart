import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

bool useBlinker(Duration period, [bool initialState = false]) {
  final blinker = useState(false);

  useEffect(() {
    final timer = Timer.periodic(
      period,
      (_) => blinker.value = !blinker.value,
    );

    return timer.cancel;
  }, const []);

  return blinker.value;
}
