// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Email)
final emailPod = EmailProvider._();

final class EmailProvider extends $NotifierProvider<Email, String> {
  EmailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailPod',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[preferencesPod],
        $allTransitiveDependencies: <ProviderOrFamily>[
          EmailProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = preferencesPod;

  @override
  String debugGetCreateSourceHash() => _$emailHash();

  @$internal
  @override
  Email create() => Email();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$emailHash() => r'6a5925f8086569849a8edf74ab85785dfa2dcfca';

abstract class _$Email extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
