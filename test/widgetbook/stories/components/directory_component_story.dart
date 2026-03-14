import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame_fuse/flame_fuse.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/components/directory_component.dart';
import 'package:moo/flame/mixins/has_file_system.dart';
import 'package:moo/widgets/terminal_button.dart';

@UseCase(name: 'Default', type: DirectoryComponent)
Widget buildDirectoryComponentStory(BuildContext context) {
  final type = context.knobs.object.dropdown(
    label: 'Type',
    options: FileType.values,
    labelBuilder: (type) => type.directory,
  );

  final fs = FileSystem();
  final directory = fs.createDirectory(type, 3);

  return Column(
    mainAxisSize: .min,
    children: [
      SizedBox.square(
        dimension: 500,
        child: GameWidget(
          game: _StoryGame(
            fs: fs,
            directory: directory,
          ),
        ),
      ),
      TerminalButton(
        variant: .positive,
        label: 'FILE',
        onPressed: () {
          final file = fs.createFile(directory.type, .zero);
          fs.archiveFile(file, directory);
        },
      ),
    ],
  );
}

class _StoryGame extends FlameGame with Fuse, HasFileSystem {
  _StoryGame({
    required this.fs,
    required this.directory,
  });

  @override
  final FileSystem fs;

  final Directory directory;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  void fuse() {
    world.add(
      DirectoryComponent(
        directory,
        anchor: .center,
      ),
    );
  }
}
