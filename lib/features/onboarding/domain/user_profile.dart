import 'profile_enums.dart';

/// Result of the onboarding questionnaire. There is a single profile per app.
class UserProfile {
  const UserProfile({
    this.id,
    required this.ageRange,
    required this.employment,
    this.monthlyIncomeCents,
    required this.hasDependents,
    required this.hasHighInterestDebt,
    this.debtCents,
    required this.riskScore,
    required this.riskProfile,
    required this.knowledgeLevel,
    required this.emergencyMonths,
    required this.locale,
    this.onboardingCompletedAt,
  });

  /// `null` until persisted.
  final int? id;
  final AgeRange ageRange;
  final Employment employment;
  final int? monthlyIncomeCents;
  final bool hasDependents;
  final bool hasHighInterestDebt;
  final int? debtCents;
  final int riskScore;
  final RiskProfile riskProfile;
  final KnowledgeLevel knowledgeLevel;
  final int emergencyMonths;

  /// Language code (`es` or `ca`).
  final String locale;

  /// UTC timestamp; `null` while onboarding is not completed.
  final DateTime? onboardingCompletedAt;

  bool get onboardingCompleted => onboardingCompletedAt != null;
}

/// Amount spent per month in one [ExpenseCategory].
class MonthlyExpense {
  const MonthlyExpense({required this.category, required this.amountCents});

  final ExpenseCategory category;
  final int amountCents;
}
