import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/money_field.dart';
import '../../domain/profile_enums.dart';
import '../onboarding_controller.dart';
import '../onboarding_labels.dart';
import '../widgets/choice_chips.dart';
import '../widgets/step_layout.dart';

/// Step 2: age, employment, income, dependents and high-interest debt.
class SituationStep extends ConsumerWidget {
  const SituationStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answers = ref.watch(onboardingControllerProvider).answers;
    final controller = ref.read(onboardingControllerProvider.notifier);

    return StepLayout(
      title: l10n.onboardingSituationTitle,
      children: [
        StepSectionLabel(l10n.onboardingAgeRange),
        ChoiceChips<AgeRange>(
          values: AgeRange.values,
          selected: answers.ageRange,
          labelOf: l10n.ageRange,
          onSelected: (v) => controller.update((a) => a.copyWith(ageRange: v)),
        ),
        StepSectionLabel(l10n.onboardingEmployment),
        ChoiceChips<Employment>(
          values: Employment.values,
          selected: answers.employment,
          labelOf: l10n.employment,
          onSelected: (v) =>
              controller.update((a) => a.copyWith(employment: v)),
        ),
        const SizedBox(height: 24),
        MoneyField(
          label: l10n.onboardingIncome,
          helperText: l10n.commonOptional,
          initialCents: answers.monthlyIncomeCents,
          onChanged: (cents) => controller.update(
            (a) => a.copyWith(monthlyIncomeCents: () => cents),
          ),
          onValidityChanged: (valid) =>
              controller.setInputValid('income', valid: valid),
        ),
        StepSectionLabel(l10n.onboardingDependents),
        YesNoChips(
          value: answers.hasDependents,
          yesLabel: l10n.commonYes,
          noLabel: l10n.commonNo,
          onChanged: (v) =>
              controller.update((a) => a.copyWith(hasDependents: v)),
        ),
        StepSectionLabel(l10n.onboardingDebt),
        YesNoChips(
          value: answers.hasHighInterestDebt,
          yesLabel: l10n.commonYes,
          noLabel: l10n.commonNo,
          onChanged: controller.setHighInterestDebt,
        ),
        if (answers.hasHighInterestDebt ?? false) ...[
          const SizedBox(height: 16),
          MoneyField(
            label: l10n.onboardingDebtAmount,
            helperText: l10n.commonOptional,
            initialCents: answers.debtCents,
            onChanged: (cents) =>
                controller.update((a) => a.copyWith(debtCents: () => cents)),
            onValidityChanged: (valid) =>
                controller.setInputValid('debt', valid: valid),
          ),
        ],
      ],
    );
  }
}
