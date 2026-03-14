import 'package:flame/game.dart' hide Game;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/flame/ministry_flame.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/hooks/use_state3.dart';
import 'package:moo/procgen.dart';
import 'package:moo/widgets/terminal_button.dart';

@UseCase(name: 'Default', type: Procgen)
Widget buildProcgenStory(BuildContext context) {
  final seed = context.knobs.int.input(
    label: 'Seed',
    initialValue: -1,
  );

  final size = context.knobs.int.slider(
    label: 'Size',
    description: 'How big to make the file system.',
    min: 1,
    max: 10,
    initialValue: MAX_FS_SIZE,
    divisions: 10 - 1,
  );

  final types = context.knobs.int.slider(
    label: 'File Types',
    description: 'How many file types to generate.',
    min: 1,
    max: 5,
    initialValue: 2,
    divisions: 5 - 1,
  );

  final filesPerExt = context.knobs.int.slider(
    label: 'Files Per Type',
    description: 'How many files to generate per file type.',
    min: 1,
    max: 10,
    initialValue: 3,
    divisions: 10 - 1,
  );

  final transformations = context.knobs.int.slider(
    label: 'Transformations',
    description: 'How many transformations to perform.',
    min: 1,
    max: 10,
    initialValue: 5,
    divisions: 10 - 1,
  );

  final minClusterSize = context.knobs.int.slider(
    label: 'Min Cluster Size',
    description: 'The minimum contiguous file count for transformations.',
    min: 1,
    max: 5,
    initialValue: 2,
    divisions: 5 - 1,
  );

  final moveProbability = context.knobs.double.slider(
    label: 'Move Probability',
    description: 'The probability at which to perform moves (vs. swaps).',
    min: 0.0,
    max: 1.0,
    initialValue: 0.6,
  );

  final maxMoveDistance = context.knobs.int.slider(
    label: 'Max Move Distance',
    description: 'The farthest away a move transformation can go.',
    min: 1,
    max: 6,
    initialValue: 3,
    divisions: 6 - 1,
  );

  final maxSwapDistance = context.knobs.int.slider(
    label: 'Max Swap Distance',
    description: 'The farthest away a swap transformation can go.',
    min: 1,
    max: 8,
    initialValue: 4,
    divisions: 8 - 1,
  );

  final procgen = Procgen(
    seed: seed < 0 ? null : seed,
    minClusterSize: minClusterSize,
    moveProbability: moveProbability,
    maxMoveDistance: maxMoveDistance,
    maxSwapDistance: maxSwapDistance,
  );

  return HookBuilder(
    builder: (_) {
      final (fs, _, setFs) = useState3<FileSystem?>(null);
      final (error, _, setError) = useState3<String?>(null);

      void regenerate() {
        try {
          final fs = procgen.generate(
            types: types,
            filesPerType: filesPerExt,
            transformations: transformations,
            size: size,
          );

          setFs(fs);
        } catch (error) {
          setError(error.toString());
        }
      }

      useEffect(() {
        regenerate();
      }, const []);

      return Padding(
        padding: Space.p5,
        child: Column(
          mainAxisAlignment: .center,
          spacing: Space.x5,
          children: [
            if (fs != null) //
              Expanded(
                child: GameWidget(
                  game: MinistryFlame(
                    .raw(
                      fs: fs,
                      // Otherwise it runs out of time based on the level.
                      timer: const Duration(days: 1),
                    ),
                  ),
                ),
              )
            else
              Text(
                error ?? 'GENERATING...',
                style: Typography.alert,
              ),
            TerminalButton(
              variant: .positive,
              label: 'REGENERATE',
              onPressed: () => regenerate(),
            ),
          ],
        ),
      );
    },
  );
}
