import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_metrics.dart';
import 'return_text.dart';

/// Total value of every investment with its overall return.
class TotalCard extends StatelessWidget {
  const TotalCard({super.key, required this.metrics});

  final AssetMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = theme.colorScheme.onPrimaryContainer;
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.investmentsTotalValue,
              style: theme.textTheme.labelLarge?.copyWith(color: onColor),
            ),
            const SizedBox(height: 4),
            Text(
              context.formatCurrency(metrics.currentValueCents),
              style: theme.textTheme.headlineMedium?.copyWith(color: onColor),
            ),
            const SizedBox(height: 4),
            if (metrics.hasActivity) ...[
              Text(
                context.l10n.investmentsContributedShort(
                  context.formatCurrency(metrics.netContributedCents),
                ),
                style: theme.textTheme.bodyMedium?.copyWith(color: onColor),
              ),
              ReturnText(
                returnCents: metrics.returnCents,
                ratio: metrics.returnRatio,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
