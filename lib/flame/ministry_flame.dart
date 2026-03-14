import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flame_fuse/flame_fuse.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yafsm/yafsm.dart';

import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/flame/components/directory_component.dart';
import 'package:moo/flame/components/grid_component.dart';
import 'package:moo/flame/components/location_component.dart';
import 'package:moo/flame/components/selection_border_component.dart';
import 'package:moo/flame/components/selection_ghost_component.dart';
import 'package:moo/flame/components/selection_overlay_component.dart';
import 'package:moo/flame/components/smooth_follow_behavior.dart';
import 'package:moo/flame/extensions.dart';
import 'package:moo/flame/fuses/fuse_state.dart';
import 'package:moo/flame/mixins/has_file_system.dart';
import 'package:moo/fs/file_system.dart';
import 'package:moo/game.dart';
import 'package:moo/keyboard.dart';

part 'ministry_flame.freezed.dart';

/// Implements a two-step drag-based flow for selection.
///
/// The steps are as follows:
///
///   1. Selection. The first drag compiles the selection state, culminating in a single
///       [Selection] instance.
///   2. Drag-n-Drop. The second drag carries the selection while waiting for the user to
///       decide where exactly to drop it.
///
/// It is possible for the initial selection phase to be skipped entirely, e.g. the user
/// begins to drag on a single, unselected file. In most other cases, a selection phase will
/// occur before the drag-n-drop phase.
class SelectionMachine extends Machine {
  SelectionMachine() : super('selection') {
    initialize(isIdle);
  }

  late final isIdle = state('idle');
  late final isSelecting = pstate<SelectionData>('selecting');
  late final isSelected = pstate<Selection>('selected');
  late final isDragging = pstate<DragData>('dragging');
  late final isDropping = pstate<DragData>('dropping');

  late final onSelectionStart = ptransition('selection start', {isIdle, isSelected}, isSelecting);
  late final onSelectionUpdate = ptransition('selection update', {isSelecting}, isSelecting);
  late final onSelected = ptransition('selected', {isSelecting}, isSelected);
  late final onDragStart = ptransition('drag start', {isIdle, isSelected}, isDragging);
  late final onDragUpdate = ptransition('drag update', {isDragging}, isDragging);
  late final onDrop = ptransition('drop', {isDragging}, isDropping);
  late final onDropped = transition('dropped', {isDropping}, isIdle);
}

/// Represents state data during the selection phase.
@freezed
abstract class SelectionData with _$SelectionData {
  const SelectionData._();

  const factory SelectionData({
    required Vector2 anchor,
    required Rect region,
  }) = _SelectionData;

  factory SelectionData.initialize(Vector2 cursor) => SelectionData(
    anchor: cursor,
    region: .fromPoints(cursor.toOffset(), cursor.toOffset()),
  );

  SelectionData update(Vector2 cursor) => copyWith(
    region: .fromPoints(anchor.toOffset(), cursor.toOffset()),
  );

  Selection build(FileSystem fs) {
    // floor(a - b) != floor(a) - floor(b)
    // So convert to locations (floor), then select.
    final tl = region.topLeft.toLocation();
    final br = region.bottomRight.toLocation();
    return fs.select(tl, br.x - tl.x + 1, br.y - tl.y + 1);
  }
}

/// Represents state data during the drag-n-drop phase.
@freezed
abstract class DragData with _$DragData {
  const DragData._();

  const factory DragData({
    required Selection selection,
    required Location origin,
    required Vector2 cursor,
  }) = _DragData;

  DragData update(Vector2 cursor) => copyWith(cursor: cursor);
}

class MinistryFlame extends FlameGame with Fuse, HasCollisionDetection, HasFileSystem, DragCallbacks, FuseDrags {
  MinistryFlame(this.game) : fs = game.fs;

  final Game game;

  @override
  final FileSystem fs;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  void fuse() {
    // Keep the game in sync with Flame's game loop.
    fuseUpdate(game.tick);

    //
    // GUI
    //

    // A "length" is the pixel size of the file system grid.
    final length = fs.size * CELL_SIZE;

    // We'll track our contents in order to center the viewfinder at the end.
    final contents = Vector2.zero();

    // First up: the grid at the origin.
    {
      final component = GridComponent(
        cellSize: CELL_SIZE,
        color: Palette.system,
        size: .all(length),
        priority: -1,
      );

      world.add(component);
      contents.add(component.size);
    }

    // Now place the directories to the right.
    {
      // Nice column - get it out of experimental!
      final component = ColumnComponent(
        gap: Space.x3,
        position: Vector2(length, 0),
        children: [
          for (final directory in fs.directories) //
            DirectoryComponent(directory),
        ],
      );

      world.add(component);
      contents.x += component.size.x;

      // Nudge it right.
      component.x += Space.x5;
      contents.x += Space.x5;
    }

    // Place a component at each location.
    // Don't add to the content size since it's all in the grid.
    for (var x = 0; x < fs.size; x += 1) {
      for (var y = 0; y < fs.size; y += 1) {
        world.add(LocationComponent(location: Location(x, y)));
      }
    }

    // Now have the camera look at the center of everything.
    // Looks ok for a variety of file system sizes!
    camera.viewfinder.position = contents / 2;

    //
    // Selection
    //

    final sm = SelectionMachine();

    // When a drag starts, there are three ways it can go.
    //
    //  1. The drag starts on an empty location (or shift is currently pressed),
    //     indicating the user intends to perform a selection.
    //  2. The drag starts on a selected file, indicating the user wishes to
    //     drag-n-drop the entire selection in which that file exists.
    //  3. The drag starts on an unselected file, indicating the user wishes
    //     to drag-n-drop a single, specific file, regardless of selection state.
    fuseDragStart((event) {
      final cursor = camera.globalToLocal(event.localPosition);
      final origin = cursor.toLocation();

      // Case #1: The origin is empty or we're forcing a selection.
      if (fs.hasNoContents(origin) || isShiftPressed()) {
        // Start a selection box powered by the cursor.
        sm.onSelectionStart(.initialize(cursor));
        return;
      }

      // This implementation wraps up the single-file case into a single-item
      // selection, then figures out if it should use the single-file move API
      // or the selection move API when the user finally drops it.
      final Selection selection;

      // Case #2: We're doing drag-n-drop on a selection.
      if (sm.isSelected() && sm.isSelected.data.contains(origin)) {
        selection = sm.isSelected.data;
      }
      // Case #3: We're doing drag-n-drop on the file at the origin.
      else {
        selection = .from({origin});
      }

      sm.onDragStart(
        DragData(
          selection: selection,
          origin: origin,
          cursor: cursor,
        ),
      );
    });

    // During the selection drag, keep the state updated with the cursor's position.
    fuseDragUpdate((event) {
      if (sm.isSelecting()) {
        sm.onSelectionUpdate(
          sm.isSelecting.data.update(
            camera.globalToLocal(event.localEndPosition),
          ),
        );
      }
    });

    // After the selection drag, compile the final selection.
    fuseDragEnd((_) {
      if (sm.isSelecting()) {
        sm.onSelected(sm.isSelecting.data.build(fs));
      }
    });

    // During the drag-n-drop drag, keep the state updated with the cursor's position.
    // This should be identical to the selection drag, we're just building something else.
    fuseDragUpdate((event) {
      if (sm.isDragging()) {
        sm.onDragUpdate(
          sm.isDragging.data.update(
            camera.globalToLocal(event.localEndPosition),
          ),
        );
      }
    });

    // After the drag-n-drop drag, send over the data for dropping.
    fuseDragEnd((_) {
      if (sm.isDragging()) {
        sm.onDrop(sm.isDragging.data);
      }
    });

    // Beyond this point, the various concerns of the selection process rely
    // exclusively on the transitions of the state machine.

    fuseMachine(sm);

    //
    // Dropping
    //

    // When we enter the dropping phase, perform the "drop" of drag-n-drop.
    fuseStateEnterRead(sm.isDropping, (data) {
      try {
        final hits = world.componentsAtPoint(data.cursor).toList();

        // Case #1: It was dropped on a directory component.
        final directory = hits.whereType<DirectoryComponent>().firstOrNull?.directory;

        if (directory != null) {
          game.archive(data.selection, directory);
          return;
        }

        // Case #2: It was dropped on a location.
        final target = hits.whereType<LocationComponent>().firstOrNull?.location;

        if (target != null) {
          // Don't perform drag-n-drop to the same location.
          if (target == data.origin) return;

          // Use the appropriate FS API based on the size of the selection.
          if (data.selection.length == 1) {
            final file = fs.contents(data.origin)!;
            fs.moveFile(file, target);
          } else {
            // Move the selection relative to where we grabbed it.
            final relativeTarget = target + data.selection.origin - data.origin;
            fs.moveSelection(data.selection, relativeTarget);
          }
        }
      } finally {
        // Always proceed directly to the next state.
        // (Would be nice if Dart had a `defer` keyword.)
        sm.onDropped();
      }
    });

    //
    // Selection Overlay
    //

    {
      const OVERLAY_SPEED = 25.0;
      final overlay = SelectionOverlayComponent();
      final targetPosition = Vector2.zero();
      final targetSize = Vector2.zero();

      overlay.addAll([
        SmoothFollowBehavior(
          source: overlay.position,
          target: targetPosition,
          speed: OVERLAY_SPEED,
          snap: true,
        ),
        SmoothFollowBehavior(
          source: overlay.size,
          target: targetSize,
          speed: OVERLAY_SPEED,
          snap: true,
        ),
      ]);

      // Add the overlay during selection.
      fuseStateEnter(sm.isSelecting, () {
        if (!overlay.isMounted) world.add(overlay);
      });

      // Have the overlay represent the position and size of the selection region.
      fuseStateEnterRead(sm.isSelecting, (data) {
        final region = data.region;
        targetPosition.setValues(region.left, region.top);
        targetSize.setValues(region.width, region.height);
      });

      // Remove the overlay when selection completes.
      fuseStateEnter(sm.isSelected, overlay.removeFromParent);
    }

    //
    // Selection Borders
    //

    {
      final borders = <Location, SelectionBorderComponent>{};

      // Maintain borders around all selected locations.
      fuseStateEnterRead(sm.isSelecting, (data) {
        final selection = data.build(fs);

        // Remove stale borders.
        final stale = borders.keys.toSet().difference(selection.locations);

        for (final location in stale) {
          borders.remove(location)?.removeFromParent();
        }

        // Add missing borders.
        for (final location in selection.locations) {
          borders.putIfAbsent(location, () {
            final border = SelectionBorderComponent();
            LocationComponent.find(this, location).add(border);
            return border;
          });
        }
      });

      // When selection is over, clean the borders up.
      fuseStateExit(sm.isSelected, () {
        for (final border in borders.values) {
          border.removeFromParent();
        }

        borders.clear();
      });
    }

    //
    // Selection Ghost
    //

    {
      SelectionGhostComponent? ghost;
      final target = Vector2.zero();

      void setup(DragData data) {
        assert(ghost == null);

        final next = SelectionGhostComponent(
          selection: data.selection,
          origin: data.origin,
          position: target,
        );

        next.add(
          SmoothFollowBehavior(
            source: next.position,
            target: target,
            snap: true,
          ),
        );

        world.add(ghost = next);
      }

      void teardown() {
        ghost?.removeFromParent();
        ghost = null;
      }

      fuseStateEnterRead(sm.isDragging, (data) {
        target.setFrom(data.cursor);
        if (ghost == null) setup(data);
      });

      fuseStateEnter(sm.isIdle, teardown);
      fuseStateEnter(sm.isSelected, teardown);
    }
  }
}
