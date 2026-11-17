import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/asset_summary.dart';
import '../asset_metadata_labels.dart';
import 'return_text.dart';

/// One asset in a category list: name, key details, value and return.
class AssetTile extends StatelessWidget {
  const AssetTile({super.key, required this.summary, required this.onTap});

  final AssetSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = summary.metrics;
    final details = context.l10n.assetDetailsLine(context, summary.asset);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(summary.asset.name),
      subtitle: details.isEmpty ? null : Text(details),
      onTap: onTap,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
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
    );
  }
}
