import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../learn/data/tips_repository.dart';
import '../../../learn/domain/tip.dart';

/// Tip of the day, in the current language.
class TipCard extends ConsumerWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Localizations.localeOf(context).languageCode;
    final tips = ref.watch(tipsProvider(language)).value;
    final tip = tips == null ? null : Tip.ofTheDay(tips, DateTime.now());
    if (tip == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: theme.colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.dashboardTipOfTheDay,
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(tip.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
