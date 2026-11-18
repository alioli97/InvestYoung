import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../investments/domain/asset_metrics.dart';
import '../../../investments/domain/investment_enums.dart';
import '../../../investments/presentation/investment_labels.dart';

Color categoryColor(AssetCategory category, ColorScheme colors) =>
    switch (category) {
      AssetCategory.emergency => colors.primary,
      AssetCategory.fixedIncome => colors.secondary,
      AssetCategory.equity => colors.tertiary,
      AssetCategory.crypto => const Color(0xFFE8A317),
    };

/// Pie chart of the current value per investment category.
class AllocationChart extends StatelessWidget {
  const AllocationChart({super.key, required this.totals});

  final Map<AssetCategory, AssetMetrics> totals;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final entries = [
      for (final category in AssetCategory.values)
        if ((totals[category]?.currentValueCents ?? 0) > 0)
          (category, totals[category]!.currentValueCents),
    ];
    final total = entries.fold(0, (sum, e) => sum + e.$2);
    if (total == 0) return const SizedBox.shrink();

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dashboardAllocation, style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                // The legend next to it reads every category and percentage.
                ExcludeSemantics(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 28,
                        sectionsSpace: 2,
                        sections: [
                          for (final (category, cents) in entries)
                            PieChartSectionData(
                              value: cents.toDouble(),
                              color: categoryColor(category, theme.colorScheme),
                              radius: 30,
                              showTitle: false,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final (category, cents) in entries)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              ExcludeSemantics(
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: categoryColor(
                                    category,
                                    theme.colorScheme,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(l10n.assetCategory(category)),
                              ),
                              Text(
                                context.formatPercent(
                                  cents / total,
                                  decimalDigits: 0,
                                ),
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
