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
