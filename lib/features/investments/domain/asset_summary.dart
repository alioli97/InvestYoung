import 'asset.dart';
import 'asset_metrics.dart';
import 'asset_transaction.dart';
import 'investment_enums.dart';

/// An asset together with the metrics of its transactions.
class AssetSummary {
  const AssetSummary({required this.asset, required this.metrics});

  final Asset asset;
  final AssetMetrics metrics;

  /// Pairs every asset with the metrics of its own transactions.
  static List<AssetSummary> build(
    List<Asset> assets,
    List<AssetTransaction> transactions,
  ) {
    final byAsset = <int, List<AssetTransaction>>{};
    for (final tx in transactions) {
      byAsset.putIfAbsent(tx.assetId, () => []).add(tx);
    }
    return [
      for (final asset in assets)
        AssetSummary(
          asset: asset,
          metrics: AssetMetrics.fromTransactions(byAsset[asset.id] ?? const []),
        ),
    ];
  }

  /// Aggregated metrics per category (every category present, maybe empty).
  static Map<AssetCategory, AssetMetrics> totalsByCategory(
    List<AssetSummary> summaries,
  ) => {
    for (final category in AssetCategory.values)
      category: AssetMetrics.sum(
        summaries
            .where((s) => s.asset.category == category)
            .map((s) => s.metrics),
      ),
  };
}
