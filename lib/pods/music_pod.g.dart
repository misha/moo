// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(music)
final musicPod = MusicProvider._();

final class MusicProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  MusicProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'musicPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[settingsPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          MusicProvider.$allTransitiveDependencies0,
          MusicProvider.$allTransitiveDependencies1,
          MusicProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = settingsPod;
  static final $allTransitiveDependencies1 =
      SettingsProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      SettingsProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$musicHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return music(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$musicHash() => r'68ea38ccad6cc18e1cab51085054ace0bfe99f99';
