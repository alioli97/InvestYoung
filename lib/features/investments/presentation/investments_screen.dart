import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/async_value_view.dart';
import '../domain/asset_metrics.dart';
import '../domain/investment_enums.dart';
import 'investments_providers.dart';
import 'widgets/category_card.dart';
import 'widgets/total_card.dart';

/// Investments tab: overall total and the 4 categories with their totals.
class InvestmentsScreen extends ConsumerWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(categoryTotalsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.investmentsTitle)),
      body: AsyncValueView(
        value: totals,
        data: (totals) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TotalCard(metrics: AssetMetrics.sum(totals.values)),
            const SizedBox(height: 16),
            for (final category in AssetCategory.values) ...[
              CategoryCard(category: category, metrics: totals[category]!),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
