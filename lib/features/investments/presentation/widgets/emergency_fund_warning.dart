import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../goals/presentation/goals_providers.dart';
import '../../domain/investment_enums.dart';

/// Informative, non-blocking warning shown when adding a riskier asset
/// (Equities or Crypto) while the emergency fund is not complete.
class EmergencyFundWarning extends ConsumerWidget {
  const EmergencyFundWarning({super.key, required this.category});

  final AssetCategory category;

  static bool appliesTo(AssetCategory category) =>
      category == AssetCategory.equity || category == AssetCategory.crypto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!appliesTo(category)) return const SizedBox.shrink();
    final progress = ref.watch(emergencyProgressProvider).value;
    if (progress == null || !progress.hasTarget || progress.isComplete) {
      return const SizedBox.shrink();
    }
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: colors.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: colors.onTertiaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.l10n.investmentsEmergencyWarning(
                    context.formatCurrency(progress.currentCents),
                    context.formatCurrency(progress.targetCents),
                  ),
                  style: TextStyle(color: colors.onTertiaryContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
