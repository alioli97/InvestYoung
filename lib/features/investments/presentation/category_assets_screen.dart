import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../domain/asset_metrics.dart';
import '../domain/investment_enums.dart';
import 'investment_labels.dart';
import 'investments_providers.dart';
import 'widgets/asset_tile.dart';
import 'widgets/category_card.dart';

/// Assets of one category, with the category total on top.
class CategoryAssetsScreen extends ConsumerWidget {
  const CategoryAssetsScreen({super.key, required this.category});

  final AssetCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final summaries = ref.watch(categoryAssetsProvider(category));
    void add() => context.push(Routes.newAsset(category));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.assetCategory(category))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: add,
        icon: const Icon(Icons.add),
        label: Text(l10n.investmentsAddAsset),
      ),
      body: AsyncValueView(
        value: summaries,
        data: (summaries) => summaries.isEmpty
            ? EmptyState(
                icon: assetCategoryIcon(category),
                title: l10n.investmentsEmptyCategory,
                message: l10n.assetCategoryExamples(category),
                actionLabel: l10n.investmentsAddAsset,
                onAction: add,
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                children: [
                  CategoryCard(
                    category: category,
                    metrics: AssetMetrics.sum(summaries.map((s) => s.metrics)),
                  ),
                  const SizedBox(height: 8),
                  for (final summary in summaries)
                    AssetTile(
                      summary: summary,
                      onTap: () =>
                          context.push(Routes.asset(summary.asset.id!)),
                    ),
                ],
              ),
      ),
    );
  }
}
