import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/investments_repository.dart';
import '../domain/asset.dart';
import '../domain/asset_metrics.dart';
import '../domain/asset_summary.dart';
import '../domain/asset_transaction.dart';
import '../domain/investment_enums.dart';

part 'investments_providers.g.dart';

/// Active (non-archived) assets.
@riverpod
Stream<List<Asset>> assets(Ref ref) =>
    ref.watch(investmentsRepositoryProvider).watchAssets();

/// Every transaction of every asset.
@riverpod
Stream<List<AssetTransaction>> allTransactions(Ref ref) =>
    ref.watch(investmentsRepositoryProvider).watchTransactions();

/// Active assets with their metrics; updates when any asset or transaction
/// changes.
@riverpod
Future<List<AssetSummary>> assetSummaries(Ref ref) async {
  final assets = await ref.watch(assetsProvider.future);
  final transactions = await ref.watch(allTransactionsProvider.future);
  return AssetSummary.build(assets, transactions);
}

/// Aggregated metrics per category.
@riverpod
Future<Map<AssetCategory, AssetMetrics>> categoryTotals(Ref ref) async =>
    AssetSummary.totalsByCategory(
      await ref.watch(assetSummariesProvider.future),
    );

/// Active assets of one category with their metrics.
@riverpod
Future<List<AssetSummary>> categoryAssets(
  Ref ref,
  AssetCategory category,
) async => [
  for (final summary in await ref.watch(assetSummariesProvider.future))
    if (summary.asset.category == category) summary,
];

/// One asset, or `null` if it does not exist (e.g. after deleting it).
@riverpod
Stream<Asset?> asset(Ref ref, int id) =>
    ref.watch(investmentsRepositoryProvider).watchAsset(id);

/// Transactions of one asset, oldest first.
@riverpod
Stream<List<AssetTransaction>> assetTransactions(Ref ref, int assetId) => ref
    .watch(investmentsRepositoryProvider)
    .watchTransactions(assetId: assetId);
