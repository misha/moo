// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'high_score_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HighScoreManager)
final highScoreManagerPod = HighScoreManagerProvider._();

final class HighScoreManagerProvider
    extends $NotifierProvider<HighScoreManager, HighScore> {
  HighScoreManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'highScoreManagerPod',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[preferencesPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HighScoreManagerProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = preferencesPod;

  @override
  String debugGetCreateSourceHash() => _$highScoreManagerHash();

  @$internal
  @override
  HighScoreManager create() => HighScoreManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HighScore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HighScore>(value),
    );
  }
}

String _$highScoreManagerHash() => r'a0aa164ddb93aee65f8c1dc59f247302fcf46682';

abstract class _$HighScoreManager extends $Notifier<HighScore> {
  HighScore build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HighScore, HighScore>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HighScore, HighScore>,
              HighScore,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(highScore)
final highScorePod = HighScoreProvider._();

final class HighScoreProvider
    extends $FunctionalProvider<HighScore, HighScore, HighScore>
    with $Provider<HighScore> {
  HighScoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'highScorePod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[highScoreManagerPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HighScoreProvider.$allTransitiveDependencies0,
          HighScoreProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = highScoreManagerPod;
  static final $allTransitiveDependencies1 =
      HighScoreManagerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$highScoreHash();

  @$internal
  @override
  $ProviderElement<HighScore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HighScore create(Ref ref) {
    return highScore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HighScore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HighScore>(value),
    );
  }
}

String _$highScoreHash() => r'1b8be837f14c42edcf98a914d3bbe9393a79249b';
