// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(game)
final gamePod = GameProvider._();

final class GameProvider extends $FunctionalProvider<Game, Game, Game>
    with $Provider<Game> {
  GameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamePod',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameHash();

  @$internal
  @override
  $ProviderElement<Game> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Game create(Ref ref) {
    return game(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Game value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Game>(value),
    );
  }
}

String _$gameHash() => r'aca58b7e597c2b6887c6e40727fb98abdb9a14af';
