// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Active (non-archived) assets.

@ProviderFor(assets)
final assetsProvider = AssetsProvider._();

/// Active (non-archived) assets.

final class AssetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Asset>>,
          List<Asset>,
          Stream<List<Asset>>
        >
    with $FutureModifier<List<Asset>>, $StreamProvider<List<Asset>> {
  /// Active (non-archived) assets.
  AssetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetsHash();

  @$internal
  @override
  $StreamProviderElement<List<Asset>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Asset>> create(Ref ref) {
    return assets(ref);
  }
}

String _$assetsHash() => r'240d72a9fa5edbdb942312145880faaad39183f7';

/// Every transaction of every asset.

@ProviderFor(allTransactions)
final allTransactionsProvider = AllTransactionsProvider._();

/// Every transaction of every asset.

final class AllTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssetTransaction>>,
          List<AssetTransaction>,
          Stream<List<AssetTransaction>>
        >
    with
        $FutureModifier<List<AssetTransaction>>,
        $StreamProvider<List<AssetTransaction>> {
  /// Every transaction of every asset.
  AllTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTransactionsHash();

  @$internal
  @override
  $StreamProviderElement<List<AssetTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AssetTransaction>> create(Ref ref) {
    return allTransactions(ref);
  }
}

String _$allTransactionsHash() => r'abc927a244717232622a3683da354b8cfa76cea7';

/// Active assets with their metrics; updates when any asset or transaction
/// changes.

@ProviderFor(assetSummaries)
final assetSummariesProvider = AssetSummariesProvider._();

/// Active assets with their metrics; updates when any asset or transaction
/// changes.

final class AssetSummariesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssetSummary>>,
          List<AssetSummary>,
          FutureOr<List<AssetSummary>>
        >
    with
        $FutureModifier<List<AssetSummary>>,
        $FutureProvider<List<AssetSummary>> {
  /// Active assets with their metrics; updates when any asset or transaction
  /// changes.
  AssetSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetSummariesHash();

  @$internal
  @override
  $FutureProviderElement<List<AssetSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssetSummary>> create(Ref ref) {
    return assetSummaries(ref);
  }
}

String _$assetSummariesHash() => r'e9b0184821cec81272797a40fe76280c5735a44d';

/// Aggregated metrics per category.

@ProviderFor(categoryTotals)
final categoryTotalsProvider = CategoryTotalsProvider._();

/// Aggregated metrics per category.

final class CategoryTotalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<AssetCategory, AssetMetrics>>,
          Map<AssetCategory, AssetMetrics>,
          FutureOr<Map<AssetCategory, AssetMetrics>>
        >
    with
        $FutureModifier<Map<AssetCategory, AssetMetrics>>,
        $FutureProvider<Map<AssetCategory, AssetMetrics>> {
  /// Aggregated metrics per category.
  CategoryTotalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryTotalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryTotalsHash();

  @$internal
  @override
  $FutureProviderElement<Map<AssetCategory, AssetMetrics>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<AssetCategory, AssetMetrics>> create(Ref ref) {
    return categoryTotals(ref);
  }
}

String _$categoryTotalsHash() => r'3d64d23cb951491db64dd952648c08674fe1d5ed';

/// Active assets of one category with their metrics.

@ProviderFor(categoryAssets)
final categoryAssetsProvider = CategoryAssetsFamily._();

/// Active assets of one category with their metrics.

final class CategoryAssetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssetSummary>>,
          List<AssetSummary>,
          FutureOr<List<AssetSummary>>
        >
    with
        $FutureModifier<List<AssetSummary>>,
        $FutureProvider<List<AssetSummary>> {
  /// Active assets of one category with their metrics.
  CategoryAssetsProvider._({
    required CategoryAssetsFamily super.from,
    required AssetCategory super.argument,
  }) : super(
         retry: null,
         name: r'categoryAssetsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryAssetsHash();

  @override
  String toString() {
    return r'categoryAssetsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AssetSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssetSummary>> create(Ref ref) {
    final argument = this.argument as AssetCategory;
    return categoryAssets(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryAssetsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryAssetsHash() => r'87568c2eae29afc014f981a38125dc8207a218ee';

/// Active assets of one category with their metrics.

final class CategoryAssetsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<AssetSummary>>, AssetCategory> {
  CategoryAssetsFamily._()
    : super(
        retry: null,
        name: r'categoryAssetsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Active assets of one category with their metrics.

  CategoryAssetsProvider call(AssetCategory category) =>
      CategoryAssetsProvider._(argument: category, from: this);

  @override
  String toString() => r'categoryAssetsProvider';
}

/// One asset, or `null` if it does not exist (e.g. after deleting it).

@ProviderFor(asset)
final assetProvider = AssetFamily._();

/// One asset, or `null` if it does not exist (e.g. after deleting it).

final class AssetProvider
    extends $FunctionalProvider<AsyncValue<Asset?>, Asset?, Stream<Asset?>>
    with $FutureModifier<Asset?>, $StreamProvider<Asset?> {
  /// One asset, or `null` if it does not exist (e.g. after deleting it).
  AssetProvider._({
    required AssetFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'assetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetHash();

  @override
  String toString() {
    return r'assetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Asset?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Asset?> create(Ref ref) {
    final argument = this.argument as int;
    return asset(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetHash() => r'6772e83b19e54ce9827a7070377c83f0e3e46b7e';

/// One asset, or `null` if it does not exist (e.g. after deleting it).

final class AssetFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Asset?>, int> {
  AssetFamily._()
    : super(
        retry: null,
        name: r'assetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One asset, or `null` if it does not exist (e.g. after deleting it).

  AssetProvider call(int id) => AssetProvider._(argument: id, from: this);

  @override
  String toString() => r'assetProvider';
}

/// Transactions of one asset, oldest first.

@ProviderFor(assetTransactions)
final assetTransactionsProvider = AssetTransactionsFamily._();

/// Transactions of one asset, oldest first.

final class AssetTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssetTransaction>>,
          List<AssetTransaction>,
          Stream<List<AssetTransaction>>
        >
    with
        $FutureModifier<List<AssetTransaction>>,
        $StreamProvider<List<AssetTransaction>> {
  /// Transactions of one asset, oldest first.
  AssetTransactionsProvider._({
    required AssetTransactionsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'assetTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetTransactionsHash();

  @override
  String toString() {
    return r'assetTransactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<AssetTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AssetTransaction>> create(Ref ref) {
    final argument = this.argument as int;
    return assetTransactions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetTransactionsHash() => r'4926d49588b2d36d1207a755621e2a33a4cb93c5';

/// Transactions of one asset, oldest first.

final class AssetTransactionsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<AssetTransaction>>, int> {
  AssetTransactionsFamily._()
    : super(
        retry: null,
        name: r'assetTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Transactions of one asset, oldest first.

  AssetTransactionsProvider call(int assetId) =>
      AssetTransactionsProvider._(argument: assetId, from: this);

  @override
  String toString() => r'assetTransactionsProvider';
}
