import 'package:moo/fs/objects/file_type.dart';

class Directory {
  Directory(this.type, this.capacity);

  final FileType type;
  final int capacity;

  int _size = 0;
  int get size => _size;
  double get usage => _size / capacity;
  bool get isFull => _size >= capacity;

  bool file() {
    if (isFull) return false;
    _size += 1;
    return true;
  }
}
