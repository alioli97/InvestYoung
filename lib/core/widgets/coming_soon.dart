import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

/// Centered placeholder used by sections that are not implemented yet.
class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            context.l10n.commonComingSoon,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
