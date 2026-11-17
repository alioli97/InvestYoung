import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_metrics.dart';
import '../../domain/investment_enums.dart';
import 'return_text.dart';

/// Current value and return of an asset.
class AssetMetricsCard extends StatelessWidget {
  const AssetMetricsCard({
    super.key,
    required this.category,
    required this.metrics,
  });

  final AssetCategory category;
  final AssetMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.investmentsCurrentValue,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              context.formatCurrency(metrics.currentValueCents),
              style: theme.textTheme.headlineSmall,
            ),
            if (metrics.hasActivity)
              ReturnText(
                returnCents: metrics.returnCents,
                ratio: metrics.returnRatio,
              ),
          ],
        ),
      ),
    );
  }
}
