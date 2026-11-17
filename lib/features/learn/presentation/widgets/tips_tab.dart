import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../data/tips_repository.dart';
import '../../domain/tip.dart';

/// Every quick tip, with today's tip first and highlighted.
class TipsTab extends ConsumerWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Localizations.localeOf(context).languageCode;
    return AsyncValueView(
      value: ref.watch(tipsProvider(language)),
      data: (tips) {
        final today = Tip.ofTheDay(tips, DateTime.now());
        final ordered = [?today, ...tips.where((t) => t.id != today?.id)];
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: ordered.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, i) =>
              _TipTile(tip: ordered[i], isToday: ordered[i].id == today?.id),
        );
      },
    );
  }
}

class _TipTile extends StatelessWidget {
  const _TipTile({required this.tip, required this.isToday});

  final Tip tip;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card(
      color: isToday
          ? colors.secondaryContainer
          : colors.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(isToday ? Icons.lightbulb : Icons.lightbulb_outline),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isToday) ...[
                    Text(
                      context.l10n.dashboardTipOfTheDay,
                      style: theme.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                  ],
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
