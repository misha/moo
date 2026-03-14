import 'package:flame_fuse/flame_fuse.dart';

import 'package:moo/fs/file_system.dart';
import 'package:moo/flame/mixins/has_file_system.dart';

FileSystem fuseFileSystem() => fuseGame<HasFileSystem>().fs;

/// Calls the [watcher] whenever the [directory] changes, including immediately.
///
/// The watcher may optionally return a cleanup function, called when the directory changes,
/// as well as when this component is unmounted.
void fuseDirectoryWatcher(
  Directory directory,
  Function? Function(Directory directory) watcher,
) {
  final fs = fuseFileSystem();
  var cleanup = watcher(directory);

  fuseRemove(
    fs.watchDirectory(directory, (directory) {
      cleanup?.call();
      cleanup = watcher(directory);
    }),
  );

  fuseRemove(() => cleanup?.call());
}

/// Calls the [watcher] whenever the file at [location] changes, including immediately.
///
/// The watcher may optionally return a cleanup function, called when the location changes,
/// as well as when this component is unmounted.
void fuseLocationWatcher(
  Location location,
  Function? Function(File? file) watcher,
) {
  final fs = fuseFileSystem();
  var cleanup = watcher(fs.contents(location));

  fuseRemove(
    fs.watchLocation(location, (file) {
      cleanup?.call();
      cleanup = watcher(file);
    }),
  );

  fuseRemove(() => cleanup?.call());
}
