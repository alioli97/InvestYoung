import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/l10n/money_input.dart';
import '../../../../core/widgets/percent_field.dart';
import '../../../onboarding/presentation/profile_providers.dart';
import '../../domain/goal_params.dart';
import '../../domain/goal_type.dart';

/// Type-specific inputs of a goal, edited as a params map.
class GoalTypeFields extends StatelessWidget {
  const GoalTypeFields({
    super.key,
    required this.type,
    required this.params,
    required this.onChanged,
  });

  final GoalType type;
  final Map<String, Object?> params;
  final ValueChanged<Map<String, Object?>> onChanged;

  void _set(String key, Object? value) => onChanged({...params, key: value});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const gap = SizedBox(height: 16);
    return switch (type) {
      GoalType.emergency => _EmergencyMonths(
        months: GoalParams.intValue(params, GoalParams.months),
        onChanged: (m) => _set(GoalParams.months, m),
      ),
      GoalType.housing => Column(
        children: [
          _CentsField(
            label: l10n.goalsHomePrice,
            initialCents: GoalParams.intValue(
              params,
              GoalParams.homePriceCents,
            ),
            onChanged: (c) => _set(GoalParams.homePriceCents, c),
          ),
          gap,
          PercentField(
            label: l10n.goalsDownPayment,
            initialRatio:
                GoalParams.ratio(params, GoalParams.downPaymentPct) ??
                GoalParams.defaultDownPayment,
            required: true,
            onChanged: (r) => _set(GoalParams.downPaymentPct, r),
          ),
          gap,
          PercentField(
            label: l10n.goalsFees,
            helperText: l10n.goalsFeesHelp,
            initialRatio:
                GoalParams.ratio(params, GoalParams.feesPct) ??
                GoalParams.defaultFees,
            required: true,
            onChanged: (r) => _set(GoalParams.feesPct, r),
          ),
        ],
      ),
      GoalType.retirement => Column(
        children: [
          _AgeField(
            label: l10n.goalsCurrentAge,
            initial: GoalParams.intValue(params, GoalParams.currentAge),
            onChanged: (a) => _set(GoalParams.currentAge, a),
          ),
          gap,
          _AgeField(
            label: l10n.goalsRetirementAge,
            initial:
                GoalParams.intValue(params, GoalParams.retirementAge) ??
                GoalParams.defaultRetirementAge,
            minAge:
                (GoalParams.intValue(params, GoalParams.currentAge) ?? 15) + 1,
            onChanged: (a) => _set(GoalParams.retirementAge, a),
          ),
          gap,
          _CentsField(
            label: l10n.goalsMonthlySpending,
            helperText: l10n.goalsMonthlySpendingHelp,
            initialCents: GoalParams.intValue(
              params,
              GoalParams.monthlySpendingCents,
            ),
            onChanged: (c) => _set(GoalParams.monthlySpendingCents, c),
          ),
        ],
      ),
      GoalType.custom => const SizedBox.shrink(),
    };
  }
}

/// Months slider for the emergency fund, showing the recommended range.
class _EmergencyMonths extends ConsumerWidget {
  const _EmergencyMonths({required this.months, required this.onChanged});

  final int? months;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final range = ref.watch(recommendedEmergencyRangeProvider).value;
    final value = (months ?? range?.defaultMonths ?? 6).clamp(1, 24);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.goalsMonthsCovered),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 24,
          divisions: 23,
          label: l10n.onboardingResultMonths(value),
          onChanged: (v) => onChanged(v.round()),
        ),
        Text(l10n.onboardingResultMonths(value)),
        if (range != null)
          Text(
            l10n.goalsRecommendedMonths(range.min, range.max),
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

/// Required euro amount; reports cents (`null` when invalid).
class _CentsField extends StatelessWidget {
  const _CentsField({
    required this.label,
    required this.initialCents,
    required this.onChanged,
    this.helperText,
  });

  final String label;
  final int? initialCents;
  final ValueChanged<int?> onChanged;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final initial = initialCents;
    return TextFormField(
      initialValue: initial == null ? null : formatCentsForInput(initial),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        suffixText: '€',
      ),
      validator: (v) {
        final cents = parseEurosToCents(v ?? '');
        if (cents == null) return l10n.commonInvalidAmount;
        return cents == 0 ? l10n.investmentsAmountPositive : null;
      },
      onChanged: (v) => onChanged(parseEurosToCents(v)),
    );
  }
}

class _AgeField extends StatelessWidget {
  const _AgeField({
    required this.label,
    required this.initial,
    required this.onChanged,
    this.minAge = 16,
  });

  final String label;
  final int? initial;
  final ValueChanged<int?> onChanged;
  final int minAge;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      initialValue: initial?.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        final age = int.tryParse(v ?? '');
        if (age == null) return l10n.commonRequired;
        return age < minAge || age > 100
            ? l10n.goalsInvalidAge(minAge, 100)
            : null;
      },
      onChanged: (v) => onChanged(int.tryParse(v)),
    );
  }
}
