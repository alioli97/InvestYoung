import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_metrics.dart';
import '../../domain/investment_enums.dart';
import 'return_text.dart';

/// Metrics of an asset (docs/SPEC.md §6): value, contributed capital,
/// income, return and, for Equities and Crypto, units and average price.
class AssetMetricsCard extends StatelessWidget {
  const AssetMetricsCard({
    super.key,
    required this.category,
    required this.metrics,
  });

  final AssetCategory category;
  final AssetMetrics metrics;

  bool get _showHoldings =>
      category == AssetCategory.equity || category == AssetCategory.crypto;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final avgPrice = metrics.averagePurchasePriceCents;
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.investmentsCurrentValue,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              context.formatCurrency(metrics.currentValueCents),
              style: theme.textTheme.headlineSmall,
            ),
            const Divider(height: 24),
            _MetricRow(
              label: l10n.investmentsNetContributed,
              value: Text(context.formatCurrency(metrics.netContributedCents)),
            ),
            if (metrics.incomeCents != 0)
              _MetricRow(
                label: l10n.investmentsIncome,
                value: Text(context.formatCurrency(metrics.incomeCents)),
              ),
            _MetricRow(
              label: l10n.investmentsReturn,
              value: ReturnText(
                returnCents: metrics.returnCents,
                ratio: metrics.returnRatio,
              ),
            ),
            if (_showHoldings) ...[
              _MetricRow(
                label: l10n.investmentsHoldings,
                value: Text(context.formatQuantity(metrics.holdings)),
              ),
              if (avgPrice != null)
                _MetricRow(
                  label: l10n.investmentsAveragePrice,
                  value: Text(context.formatUnitPrice(avgPrice)),
                ),
            ],
            const SizedBox(height: 8),
            Text(
              l10n.investmentsReturnExplanation,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: 8),
          value,
        ],
      ),
    );
  }
}
