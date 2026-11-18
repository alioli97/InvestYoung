import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../investments/domain/asset_metrics.dart';
import '../../../investments/presentation/widgets/return_text.dart';

/// Total net worth: current value of every asset.
class NetWorthCard extends StatelessWidget {
  const NetWorthCard({super.key, required this.metrics});

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
              context.l10n.dashboardNetWorth,
              style: theme.textTheme.labelLarge?.copyWith(color: onColor),
            ),
            const SizedBox(height: 4),
            Text(
              context.formatCurrency(metrics.currentValueCents),
              style: theme.textTheme.headlineMedium?.copyWith(color: onColor),
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
