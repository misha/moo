// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Screen)
final screenPod = ScreenProvider._();

final class ScreenProvider extends $NotifierProvider<Screen, Widget> {
  ScreenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenPod',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[gamePod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ScreenProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = gamePod;

  @override
  String debugGetCreateSourceHash() => _$screenHash();

  @$internal
  @override
  Screen create() => Screen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Widget value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Widget>(value),
    );
  }
}

String _$screenHash() => r'017443c86457e4b5edf4fc043ab67c22cea52616';

abstract class _$Screen extends $Notifier<Widget> {
  Widget build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Widget, Widget>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Widget, Widget>,
              Widget,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
