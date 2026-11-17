import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/money_field.dart';
import '../../domain/profile_enums.dart';
import '../onboarding_controller.dart';
import '../onboarding_labels.dart';
import '../widgets/step_layout.dart';

/// Step 3: monthly expenses by category with a live total.
class ExpensesStep extends ConsumerWidget {
  const ExpensesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answers = ref.watch(onboardingControllerProvider).answers;
    final controller = ref.read(onboardingControllerProvider.notifier);

    return StepLayout(
      title: l10n.onboardingExpensesTitle,
      subtitle: l10n.onboardingExpensesSubtitle,
      children: [
        for (final category in ExpenseCategory.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MoneyField(
              label: l10n.expenseCategory(category),
              initialCents: answers.expenseCents(category),
              onChanged: (cents) => controller.setExpense(category, cents),
            ),
          ),
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.onboardingExpensesTotal(
                context.formatCurrency(answers.totalExpensesCents),
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
