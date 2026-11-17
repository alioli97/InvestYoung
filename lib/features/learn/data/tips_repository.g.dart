// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tips_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tipsRepository)
final tipsRepositoryProvider = TipsRepositoryProvider._();

final class TipsRepositoryProvider
    extends $FunctionalProvider<TipsRepository, TipsRepository, TipsRepository>
    with $Provider<TipsRepository> {
  TipsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tipsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tipsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TipsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TipsRepository create(Ref ref) {
    return tipsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TipsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TipsRepository>(value),
    );
  }
}

String _$tipsRepositoryHash() => r'8b8c89d9770259c021c0066e65319b8646e06388';

/// Tips in the given language.

@ProviderFor(tips)
final tipsProvider = TipsFamily._();

/// Tips in the given language.

final class TipsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Tip>>,
          List<Tip>,
          FutureOr<List<Tip>>
        >
    with $FutureModifier<List<Tip>>, $FutureProvider<List<Tip>> {
  /// Tips in the given language.
  TipsProvider._({
    required TipsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tipsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tipsHash();

  @override
  String toString() {
    return r'tipsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Tip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Tip>> create(Ref ref) {
    final argument = this.argument as String;
    return tips(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TipsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tipsHash() => r'7ee792a9d5c2c53d7e9a6366fbef4d5964564e7c';

/// Tips in the given language.

final class TipsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Tip>>, String> {
  TipsFamily._()
    : super(
        retry: null,
        name: r'tipsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Tips in the given language.

  TipsProvider call(String languageCode) =>
      TipsProvider._(argument: languageCode, from: this);

  @override
  String toString() => r'tipsProvider';
}
