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
