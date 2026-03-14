import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

DateTime useNow() {
  final now = useState(DateTime.now());

  useEffect(() {
    final timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => now.value = .now(),
    );

    return timer.cancel;
  }, const []);

  return now.value;
}
