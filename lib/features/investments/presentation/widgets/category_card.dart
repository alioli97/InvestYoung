import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_metrics.dart';
import '../../domain/investment_enums.dart';
import '../investment_labels.dart';
import 'return_text.dart';

/// One investment category with its current value and return.
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.metrics,
    this.onTap,
  });

  final AssetCategory category;
  final AssetMetrics metrics;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                child: Icon(assetCategoryIcon(category)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.assetCategory(category),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      l10n.assetCategoryExamples(category),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.formatCurrency(metrics.currentValueCents),
                    style: theme.textTheme.titleMedium,
                  ),
                  if (metrics.hasActivity)
                    ReturnText(
                      returnCents: metrics.returnCents,
                      ratio: metrics.returnRatio,
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
