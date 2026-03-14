import 'package:flutter_hooks/flutter_hooks.dart';

typedef Reader<T> = T Function();
typedef Writer<T> = void Function(T value);

(T value, Reader<T> read, Writer<T> write) useState3<T>(T initialData) {
  final state = useState(initialData);

  return (
    state.value,
    () => state.value,
    (value) => state.value = value,
  );
}
