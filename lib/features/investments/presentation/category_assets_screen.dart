import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/async_value_view.dart';
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
            ? _EmptyCategory(category: category, onAdd: add)
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
                          context.push(Routes.editAsset(summary.asset.id!)),
                    ),
                ],
              ),
      ),
    );
  }
}

class _EmptyCategory extends StatelessWidget {
  const _EmptyCategory({required this.category, required this.onAdd});

  final AssetCategory category;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              assetCategoryIcon(category),
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.investmentsEmptyCategory,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.assetCategoryExamples(category),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(context.l10n.investmentsAddAsset),
            ),
          ],
        ),
      ),
    );
  }
}
