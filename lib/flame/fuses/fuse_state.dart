import 'package:flame_fuse/flame_fuse.dart';
import 'package:yafsm/yafsm.dart';

// This file bridges `flame_fuse` and `yafsm` in two ways:
//
//  1. Allows tying state machines to the component lifecycle.
//  2. Grants state machine-watching operations a fuse-like interface.
//     (Part of this is fallout from my own poor API design in `yafsm`.)

extension<D> on MachineState<D> {
  D read() {
    if (this is ParameterizedMachineState<D>) {
      return (this as ParameterizedMachineState<D>).data;
    } else {
      return null as D;
    }
  }
}

/// Ties [machine] to this component's lifecycle.
///
/// Starts the machine immediately, then disposes of it on remove.
void fuseMachine(Machine machine) {
  machine.start();

  fuseRemove(() {
    try {
      machine.dispose();
    } catch (_) {
      // Swallow. Sometimes events are added late.
    }
  });
}

/// Calls [fn] whenever the given [state] is entered.
void fuseStateEnter(MachineState state, Function() fn) {
  state.enter$.forEach((_) => fn());
}

/// Calls [fn] whenever the given [state] is entered.
///
/// The callback receives the state data.
void fuseStateEnterRead<D>(MachineState<D> state, Function(D data) fn) {
  state.enter$.forEach((_) => fn(state.read()));
}

/// Calls [fn] whenever the given [state] is exited.
void fuseStateExit(MachineState state, Function() fn) {
  state.exit$.forEach((_) => fn());
}

/// Calls [fn] whenever the given [state] is exited.
///
/// The callback receives the state data.
void fuseStateExitRead<D>(MachineState<D> state, Function(D data) fn) {
  state.exit$.forEach((_) => fn(state.read()));
}
