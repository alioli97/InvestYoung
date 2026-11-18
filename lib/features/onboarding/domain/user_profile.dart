import '../../../core/domain/app_theme_mode.dart';
import '../../profile/domain/contribution_reminder.dart';
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
    this.themeMode = AppThemeMode.system,
    this.reminder,
    this.appLockEnabled = false,
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

  /// Changed from Profile only (`ProfileRepository.updatePreferences`);
  /// saving the questionnaire never overwrites it.
  final AppThemeMode themeMode;

  /// Monthly contribution reminder, `null` when off. Like [themeMode], it is
  /// changed from Profile only.
  final ContributionReminder? reminder;

  /// Ask for the device's biometrics/PIN on opening. Profile-only setting.
  final bool appLockEnabled;

  bool get onboardingCompleted => onboardingCompletedAt != null;

  UserProfile withEmergencyMonths(int months) => UserProfile(
    id: id,
    ageRange: ageRange,
    employment: employment,
    monthlyIncomeCents: monthlyIncomeCents,
    hasDependents: hasDependents,
    hasHighInterestDebt: hasHighInterestDebt,
    debtCents: debtCents,
    riskScore: riskScore,
    riskProfile: riskProfile,
    knowledgeLevel: knowledgeLevel,
    emergencyMonths: months,
    locale: locale,
    onboardingCompletedAt: onboardingCompletedAt,
    themeMode: themeMode,
    reminder: reminder,
    appLockEnabled: appLockEnabled,
  );
}

/// Amount spent per month in one [ExpenseCategory].
class MonthlyExpense {
  const MonthlyExpense({required this.category, required this.amountCents});

  final ExpenseCategory category;
  final int amountCents;
}
