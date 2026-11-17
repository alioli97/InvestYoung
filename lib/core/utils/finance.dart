import 'dart:math' as math;

/// Pure financial formulas from docs/SPEC.md §8.
///
/// Every function takes and returns money as integer cents. `double` is only
/// used for intermediate calculations; results are rounded to whole cents.

/// Emergency fund target: monthly expenses × [months].
int emergencyFundTarget(int monthlyExpensesCents, int months) {
  _checkNotNegative(months, 'months');
  return monthlyExpensesCents * months;
}

/// Monthly rate equivalent to [annualRate] with monthly compounding:
/// `(1 + annualRate)^(1/12) − 1`.
double monthlyRate(double annualRate) {
  if (annualRate <= -1) {
    throw ArgumentError.value(annualRate, 'annualRate', 'Must be > -1');
  }
  return math.pow(1 + annualRate, 1 / 12).toDouble() - 1;
}

/// Monthly contribution needed to grow [currentCents] to [targetCents] in
/// [months] months at [annualRate] (contributions at the end of each month).
///
/// - Clamped to a minimum of 0 (goal already reached or covered by growth).
/// - When [months] is 0 there is no time left: returns the remaining amount.
/// - Rounded up to the next cent so the target is actually reached.
int requiredMonthlyContribution({
  required int targetCents,
  required int currentCents,
  required double annualRate,
  required int months,
}) {
  _checkNotNegative(months, 'months');
  if (months == 0) return math.max(0, targetCents - currentCents);

  final r = monthlyRate(annualRate);
  final growth = math.pow(1 + r, months).toDouble();
  final remaining = targetCents - currentCents * growth;
  if (remaining <= 0) return 0;

  final monthly = r == 0 ? remaining / months : remaining * r / (growth - 1);
  // Tolerate floating-point noise before rounding up (e.g. 100.0000000001).
  return (monthly - 1e-6).ceil();
}

/// House down payment goal: home price × (down payment % + taxes and fees %).
int housingTarget({
  required int homePriceCents,
  required double downPaymentRatio,
  required double feesRatio,
}) => (homePriceCents * (downPaymentRatio + feesRatio)).round();

/// Retirement capital using the 4% rule: monthly expense × 12 × 25.
int retirementTarget(int monthlyExpenseCents) => monthlyExpenseCents * 12 * 25;

/// One month of a [projectGrowth] series.
class GrowthPoint {
  const GrowthPoint({
    required this.month,
    required this.valueCents,
    required this.contributedCents,
  });

  /// Months from now (0 = today).
  final int month;

  /// Projected value with compound interest.
  final int valueCents;

  /// Capital contributed so far (initial capital + monthly contributions).
  final int contributedCents;

  @override
  bool operator ==(Object other) =>
      other is GrowthPoint &&
      other.month == month &&
      other.valueCents == valueCents &&
      other.contributedCents == contributedCents;

  @override
  int get hashCode => Object.hash(month, valueCents, contributedCents);

  @override
  String toString() =>
      'GrowthPoint(month: $month, value: $valueCents, '
      'contributed: $contributedCents)';
}

/// Monthly projection of [currentCents] plus [monthlyCents] contributed at the
/// end of each month, compounded at [annualRate].
///
/// Returns `months + 1` points, starting with month 0 (today).
List<GrowthPoint> projectGrowth({
  required int currentCents,
  required int monthlyCents,
  required double annualRate,
  required int months,
}) {
  _checkNotNegative(months, 'months');
  final r = monthlyRate(annualRate);
  var value = currentCents.toDouble();
  final points = <GrowthPoint>[
    GrowthPoint(
      month: 0,
      valueCents: currentCents,
      contributedCents: currentCents,
    ),
  ];
  for (var month = 1; month <= months; month++) {
    value = value * (1 + r) + monthlyCents;
    points.add(
      GrowthPoint(
        month: month,
        valueCents: value.round(),
        contributedCents: currentCents + monthlyCents * month,
      ),
    );
  }
  return points;
}

void _checkNotNegative(int value, String name) {
  if (value < 0) throw ArgumentError.value(value, name, 'Must be >= 0');
}
