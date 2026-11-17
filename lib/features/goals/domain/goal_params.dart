import '../../../core/utils/dates.dart';
import '../../../core/utils/finance.dart';
import 'goal_type.dart';

/// Keys, defaults and typed accessors for `Goal.params` (stored as JSON),
/// plus how each goal type derives its target (docs/SPEC.md §5).
abstract final class GoalParams {
  // Emergency fund
  static const months = 'months';

  // Housing
  static const homePriceCents = 'homePriceCents';
  static const downPaymentPct = 'downPaymentPct';
  static const feesPct = 'feesPct';

  // Retirement
  static const currentAge = 'currentAge';
  static const retirementAge = 'retirementAge';
  static const monthlySpendingCents = 'monthlySpendingCents';

  static const defaultDownPayment = 0.20;
  static const defaultFees = 0.10;
  static const defaultRetirementAge = 67;
  static const defaultRetirementReturn = 0.05;

  static int? intValue(Map<String, Object?> params, String key) {
    final value = params[key];
    return value is num ? value.toInt() : null;
  }

  static double? ratio(Map<String, Object?> params, String key) {
    final value = params[key];
    return value is num ? value.toDouble() : null;
  }

  /// Target derived from the inputs, or `null` when inputs are missing or
  /// the type has a manual target (custom goals).
  static int? computeTarget(
    GoalType type,
    Map<String, Object?> params, {
    required int monthlyExpensesCents,
  }) {
    switch (type) {
      case GoalType.emergency:
        final m = intValue(params, months);
        return m == null ? null : emergencyFundTarget(monthlyExpensesCents, m);
      case GoalType.housing:
        final price = intValue(params, homePriceCents);
        if (price == null) return null;
        return housingTarget(
          homePriceCents: price,
          downPaymentRatio: ratio(params, downPaymentPct) ?? defaultDownPayment,
          feesRatio: ratio(params, feesPct) ?? defaultFees,
        );
      case GoalType.retirement:
        final spending = intValue(params, monthlySpendingCents);
        return spending == null ? null : retirementTarget(spending);
      case GoalType.custom:
        return null;
    }
  }

  /// Retirement date: today plus the years until [retirementAge].
  static DateTime? retirementDate(Map<String, Object?> params, DateTime now) {
    final age = intValue(params, currentAge);
    final retireAt = intValue(params, retirementAge) ?? defaultRetirementAge;
    if (age == null || retireAt <= age) return null;
    final date = addMonths(now, (retireAt - age) * 12);
    return DateTime(date.year, date.month, date.day);
  }
}
