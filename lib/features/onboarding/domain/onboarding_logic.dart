import 'profile_enums.dart';

/// Pure onboarding rules from docs/SPEC.md §3 (step 7, "Result").

/// Number of risk tolerance questions; each answer is worth 1–3 points.
const riskQuestionCount = 4;
const minRiskScore = riskQuestionCount * 1;
const maxRiskScore = riskQuestionCount * 3;

/// Sums the points of the risk answers (each 1–3).
int riskScore(List<int> answerPoints) {
  if (answerPoints.length != riskQuestionCount) {
    throw ArgumentError.value(
      answerPoints,
      'answerPoints',
      'Expected $riskQuestionCount answers',
    );
  }
  for (final points in answerPoints) {
    if (points < 1 || points > 3) {
      throw ArgumentError.value(points, 'answerPoints', 'Each must be 1–3');
    }
  }
  return answerPoints.fold(0, (sum, p) => sum + p);
}

/// Conservative (4–6), moderate (7–9) or aggressive (10–12).
RiskProfile riskProfileFromScore(int score) {
  if (score < minRiskScore || score > maxRiskScore) {
    throw ArgumentError.value(score, 'score', 'Must be 4–12');
  }
  if (score <= 6) return RiskProfile.conservative;
  if (score <= 9) return RiskProfile.moderate;
  return RiskProfile.aggressive;
}

/// Recommended size of the emergency fund, in months of expenses.
class EmergencyMonthsRange {
  const EmergencyMonthsRange(this.min, this.max);

  static const standard = EmergencyMonthsRange(3, 6);
  static const extended = EmergencyMonthsRange(6, 12);

  final int min;
  final int max;

  /// Rounded midpoint (half up), used as the slider default: 3–6 → 5, 6–12 → 9.
  int get defaultMonths => ((min + max) / 2).round();

  /// Clamps [months] into the range.
  int clamp(int months) => months.clamp(min, max);

  @override
  bool operator ==(Object other) =>
      other is EmergencyMonthsRange && other.min == min && other.max == max;

  @override
  int get hashCode => Object.hash(min, max);

  @override
  String toString() => 'EmergencyMonthsRange($min–$max)';
}

/// 6–12 months if the profile is conservative, the income is unstable
/// (temporary, self-employed, unemployed) or there are dependents; 3–6 otherwise.
EmergencyMonthsRange emergencyMonthsRange({
  required RiskProfile riskProfile,
  required Employment employment,
  required bool hasDependents,
}) {
  const unstable = {
    Employment.temporary,
    Employment.selfEmployed,
    Employment.unemployed,
  };
  final needsMore =
      riskProfile == RiskProfile.conservative ||
      unstable.contains(employment) ||
      hasDependents;
  return needsMore
      ? EmergencyMonthsRange.extended
      : EmergencyMonthsRange.standard;
}

/// Learn modules, in the order of docs/SPEC.md §7. Ids match `index.json`.
enum LearnModule {
  fundamentals('fundamentals'),
  emergencyFund('emergency-fund'),
  debt('debt'),
  fixedIncome('fixed-income'),
  equities('equities'),
  crypto('crypto'),
  taxes('taxes'),
  psychology('psychology');

  const LearnModule(this.id);

  final String id;
}

/// Modules suggested on the result screen according to prior knowledge.
List<LearnModule> recommendedModules(KnowledgeLevel level) => switch (level) {
  KnowledgeLevel.none => const [
    LearnModule.fundamentals,
    LearnModule.emergencyFund,
    LearnModule.debt,
  ],
  KnowledgeLevel.basic => const [
    LearnModule.emergencyFund,
    LearnModule.fixedIncome,
    LearnModule.equities,
  ],
  KnowledgeLevel.intermediate => const [
    LearnModule.equities,
    LearnModule.taxes,
    LearnModule.psychology,
  ],
};
