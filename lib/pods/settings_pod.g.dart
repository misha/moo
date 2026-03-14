// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsManager)
final settingsManagerPod = SettingsManagerProvider._();

final class SettingsManagerProvider
    extends $NotifierProvider<SettingsManager, Settings> {
  SettingsManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsManagerPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[preferencesPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          SettingsManagerProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = preferencesPod;

  @override
  String debugGetCreateSourceHash() => _$settingsManagerHash();

  @$internal
  @override
  SettingsManager create() => SettingsManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settings>(value),
    );
  }
}

String _$settingsManagerHash() => r'4aa4358983b8e39f7da4fde449ad0e1a8a05aca6';

abstract class _$SettingsManager extends $Notifier<Settings> {
  Settings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Settings, Settings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Settings, Settings>,
              Settings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(settings)
final settingsPod = SettingsProvider._();

final class SettingsProvider
    extends $FunctionalProvider<Settings, Settings, Settings>
    with $Provider<Settings> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[settingsManagerPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          SettingsProvider.$allTransitiveDependencies0,
          SettingsProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = settingsManagerPod;
  static final $allTransitiveDependencies1 =
      SettingsManagerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  $ProviderElement<Settings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Settings create(Ref ref) {
    return settings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settings>(value),
    );
  }
}

String _$settingsHash() => r'1df630d2264d515c3865ca1c1cde119f5b55cab4';
