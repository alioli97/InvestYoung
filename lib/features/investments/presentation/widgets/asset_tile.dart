import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_summary.dart';
import '../asset_metadata_labels.dart';
import 'return_text.dart';

/// One asset in a list: name, key details, value and return.
///
/// A custom layout instead of `ListTile.trailing`, whose fixed height cannot
/// fit the value and return with large text sizes.
class AssetTile extends StatelessWidget {
  const AssetTile({super.key, required this.summary, required this.onTap});

  final AssetSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = summary.metrics;
    final details = context.l10n.assetDetailsLine(context, summary.asset);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(summary.asset.name, style: theme.textTheme.bodyLarge),
                  if (details.isNotEmpty)
                    Text(details, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 12,
                    children: [
                      Text(
                        context.formatCurrency(metrics.currentValueCents),
                        style: theme.textTheme.titleSmall,
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
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
