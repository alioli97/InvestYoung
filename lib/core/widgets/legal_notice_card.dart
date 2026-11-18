import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

/// The legal notice (educational app, no financial advice). Shared by
/// onboarding and Profile so both always show the same text.
class LegalNoticeCard extends StatelessWidget {
  const LegalNoticeCard({super.key, this.showTitle = true});

  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTitle) ...[
              Semantics(
                header: true,
                child: Text(
                  l10n.commonLegalNoticeTitle,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(l10n.commonLegalNoticeBody),
          ],
        ),
      ),
    );
  }
}
