import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../goals/presentation/goals_providers.dart';
import '../domain/asset.dart';
import '../domain/asset_metrics.dart';
import '../domain/asset_transaction.dart';
import 'asset_metadata_labels.dart';
import 'investment_labels.dart';
import 'investments_providers.dart';
import 'widgets/asset_metrics_card.dart';
import 'widgets/transaction_tile.dart';

/// One asset: details, metrics and its transactions (newest first).
class AssetDetailScreen extends ConsumerWidget {
  const AssetDetailScreen({super.key, required this.assetId});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(assetProvider(assetId)),
      data: (asset) => asset == null
          ? const Scaffold(body: SizedBox.shrink())
          : _AssetDetail(asset: asset),
    );
  }
}

class _AssetDetail extends ConsumerWidget {
  const _AssetDetail({required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final id = asset.id!;
    final transactions = ref.watch(assetTransactionsProvider(id));
    final details = l10n.assetDetailsLine(context, asset);
    final goalName = (ref.watch(goalsProvider).value ?? const [])
        .where((g) => g.id == asset.goalId)
        .firstOrNull
        ?.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(asset.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.investmentsEditAsset,
            onPressed: () => context.push(Routes.editAsset(id)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.newTransaction(id)),
        icon: const Icon(Icons.add),
        label: Text(l10n.investmentsAddTransaction),
      ),
      body: AsyncValueView(
        value: transactions,
        data: (transactions) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Chip(
                  avatar: Icon(assetCategoryIcon(asset.category), size: 18),
                  label: Text(l10n.assetCategory(asset.category)),
                ),
                if (goalName != null)
                  Chip(
                    avatar: const Icon(Icons.flag_outlined, size: 18),
                    label: Text(goalName),
                  ),
                if (details.isNotEmpty) Text(details),
              ],
            ),
            const SizedBox(height: 8),
            AssetMetricsCard(
              category: asset.category,
              metrics: AssetMetrics.fromTransactions(transactions),
            ),
            if (asset.notes case final notes?) ...[
              const SizedBox(height: 12),
              Text(notes, style: Theme.of(context).textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            Text(
              l10n.investmentsTransactions,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            if (transactions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  l10n.investmentsNoTransactions,
                  textAlign: TextAlign.center,
                ),
              )
            else
              for (final tx in _newestFirst(transactions))
                TransactionTile(
                  tx: tx,
                  onTap: () => context.push(Routes.editTransaction(id, tx.id!)),
                ),
          ],
        ),
      ),
    );
  }

  static List<AssetTransaction> _newestFirst(List<AssetTransaction> list) =>
      list.reversed.toList();
}
