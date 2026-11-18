import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/utils/finance.dart';
import '../../domain/onboarding_logic.dart';
import '../onboarding_controller.dart';
import '../onboarding_labels.dart';
import '../widgets/step_layout.dart';

/// Step 7: risk profile, emergency fund target, warnings and lessons.
class ResultStep extends ConsumerWidget {
  const ResultStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answers = ref.watch(onboardingControllerProvider).answers;
    final profile = answers.riskProfile;
    final range = answers.emergencyRange;
    final knowledge = answers.knowledgeLevel;
    if (profile == null || range == null || knowledge == null) {
      return const SizedBox.shrink();
    }

    return StepLayout(
      title: l10n.onboardingResultTitle,
      children: [
        if (answers.hasHighInterestDebt ?? false) ...[
          const _DebtWarning(),
          const SizedBox(height: 16),
        ],
        _ResultCard(
          title: l10n.onboardingResultRiskProfile,
          children: [
            Text(
              l10n.riskProfile(profile),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(l10n.riskProfileDescription(profile)),
          ],
        ),
        const SizedBox(height: 16),
        _EmergencyFundCard(range: range),
        const SizedBox(height: 16),
        _ResultCard(
          title: l10n.onboardingResultLessons,
          children: [
            for (final module in recommendedModules(knowledge))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.school_outlined),
                title: Text(l10n.learnModule(module)),
              ),
          ],
        ),
      ],
    );
  }
}

class _EmergencyFundCard extends ConsumerWidget {
  const _EmergencyFundCard({required this.range});

  final EmergencyMonthsRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answers = ref.watch(onboardingControllerProvider).answers;
    final expenses = answers.totalExpensesCents;
    final months = answers.selectedEmergencyMonths!;

    return _ResultCard(
      title: l10n.onboardingResultEmergencyTitle,
      children: [
        Text(
          l10n.onboardingResultEmergencyRange(
            range.min,
            range.max,
            context.formatCurrency(emergencyFundTarget(expenses, range.min)),
            context.formatCurrency(emergencyFundTarget(expenses, range.max)),
          ),
        ),
        Slider(
          value: months.toDouble(),
          min: range.min.toDouble(),
          max: range.max.toDouble(),
          divisions: range.max - range.min,
          label: l10n.onboardingResultMonths(months),
          onChanged: (v) => ref
              .read(onboardingControllerProvider.notifier)
              .update((a) => a.copyWith(emergencyMonths: () => v.round())),
        ),
        Text(
          '${l10n.onboardingResultMonths(months)} · '
          '${l10n.onboardingResultTarget(context.formatCurrency(answers.emergencyTargetCents!))}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (expenses == 0) ...[
          const SizedBox(height: 8),
          Text(l10n.onboardingResultNoExpenses),
        ],
      ],
    );
  }
}

class _DebtWarning extends StatelessWidget {
  const _DebtWarning();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.errorContainer,
      child: ListTile(
        leading: Icon(
          Icons.warning_amber_rounded,
          color: colors.onErrorContainer,
        ),
        title: Text(
          context.l10n.onboardingResultDebtWarning,
          style: TextStyle(color: colors.onErrorContainer),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}
