import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';

/// Overall progress: lessons read out of the available ones.
class LearnProgressCard extends StatelessWidget {
  const LearnProgressCard({super.key, required this.read, required this.total});

  final int read;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.learnProgress(read, total),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ExcludeSemantics(
              // The text above already says "X of Y lessons read".
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : read / total,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
