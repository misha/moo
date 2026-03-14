// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Sound)
final soundPod = SoundProvider._();

final class SoundProvider extends $NotifierProvider<Sound, void> {
  SoundProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soundPod',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[settingsPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          SoundProvider.$allTransitiveDependencies0,
          SoundProvider.$allTransitiveDependencies1,
          SoundProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = settingsPod;
  static final $allTransitiveDependencies1 =
      SettingsProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      SettingsProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$soundHash();

  @$internal
  @override
  Sound create() => Sound();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$soundHash() => r'da0558a5ae2af8eb9b195cfe463f8bd3400fa046';

abstract class _$Sound extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
