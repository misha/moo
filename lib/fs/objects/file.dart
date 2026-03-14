import 'package:moo/fs/objects/file_type.dart';

class File {
  const File(this.id, this.type);

  final int id;
  final FileType type;

  @override
  bool operator ==(Object other) =>
      other is File && //
      id == other.id &&
      type == other.type;

  @override
  int get hashCode => Object.hash(id, type);
}
