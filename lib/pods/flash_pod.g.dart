// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Flash)
final flashPod = FlashProvider._();

final class FlashProvider extends $NotifierProvider<Flash, int> {
  FlashProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashPod',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashHash();

  @$internal
  @override
  Flash create() => Flash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$flashHash() => r'66f64cf200cfbde734992fc051ac5e1880c2a3ad';

abstract class _$Flash extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
