import '../../../core/utils/finance.dart';
import 'onboarding_logic.dart';
import 'profile_enums.dart';

/// Screens of the onboarding questionnaire (docs/SPEC.md §3), in order.
enum OnboardingStep {
  language,
  welcome,
  situation,
  expenses,
  risk,
  goals,
  knowledge,
  result,
}

/// Answers collected during onboarding. Immutable; derived values are getters.
class OnboardingAnswers {
  const OnboardingAnswers({
    this.legalAccepted = false,
    this.ageRange,
    this.employment,
    this.monthlyIncomeCents,
    this.hasDependents,
    this.hasHighInterestDebt,
    this.debtCents,
    this.expenses = const {},
    this.riskAnswers = const [null, null, null, null],
    this.wantsHousing = false,
    this.wantsRetirement = false,
    this.wantsCustom = false,
    this.customGoalName = '',
    this.knowledgeLevel,
    this.emergencyMonths,
  });

  final bool legalAccepted;
  final AgeRange? ageRange;
  final Employment? employment;
  final int? monthlyIncomeCents;
  final bool? hasDependents;
  final bool? hasHighInterestDebt;
  final int? debtCents;

  /// Cents per category; missing categories count as 0.
  final Map<ExpenseCategory, int> expenses;

  /// Points (1–3) of each risk answer, `null` while unanswered.
  final List<int?> riskAnswers;
  final bool wantsHousing;
  final bool wantsRetirement;
  final bool wantsCustom;
  final String customGoalName;
  final KnowledgeLevel? knowledgeLevel;

  /// Months chosen on the result slider; `null` uses the range default.
  final int? emergencyMonths;

  int expenseCents(ExpenseCategory category) => expenses[category] ?? 0;

  int get totalExpensesCents => expenses.values.fold(0, (sum, c) => sum + c);

  bool get riskCompleted => riskAnswers.every((a) => a != null);

  int? get riskScoreValue =>
      riskCompleted ? riskScore([for (final a in riskAnswers) a!]) : null;

  RiskProfile? get riskProfile {
    final score = riskScoreValue;
    return score == null ? null : riskProfileFromScore(score);
  }

  EmergencyMonthsRange? get emergencyRange {
    final profile = riskProfile;
    final job = employment;
    final dependents = hasDependents;
    if (profile == null || job == null || dependents == null) return null;
    return emergencyMonthsRange(
      riskProfile: profile,
      employment: job,
      hasDependents: dependents,
    );
  }

  /// Chosen months clamped to the range, or the range default.
  int? get selectedEmergencyMonths {
    final range = emergencyRange;
    if (range == null) return null;
    final months = emergencyMonths;
    return months == null ? range.defaultMonths : range.clamp(months);
  }

  int? get emergencyTargetCents {
    final months = selectedEmergencyMonths;
    return months == null
        ? null
        : emergencyFundTarget(totalExpensesCents, months);
  }

  /// Whether the user can move on from [step].
  bool isStepComplete(OnboardingStep step) => switch (step) {
    OnboardingStep.language => true,
    OnboardingStep.welcome => legalAccepted,
    OnboardingStep.situation =>
      ageRange != null &&
          employment != null &&
          hasDependents != null &&
          hasHighInterestDebt != null,
    OnboardingStep.expenses => true,
    OnboardingStep.risk => riskCompleted,
    OnboardingStep.goals => !wantsCustom || customGoalName.trim().isNotEmpty,
    OnboardingStep.knowledge => knowledgeLevel != null,
    OnboardingStep.result =>
      OnboardingStep.values
          .where((s) => s != OnboardingStep.result)
          .every(isStepComplete),
  };

  /// Nullable fields take a getter so they can be explicitly cleared.
  OnboardingAnswers copyWith({
    bool? legalAccepted,
    AgeRange? ageRange,
    Employment? employment,
    int? Function()? monthlyIncomeCents,
    bool? hasDependents,
    bool? hasHighInterestDebt,
    int? Function()? debtCents,
    Map<ExpenseCategory, int>? expenses,
    List<int?>? riskAnswers,
    bool? wantsHousing,
    bool? wantsRetirement,
    bool? wantsCustom,
    String? customGoalName,
    KnowledgeLevel? knowledgeLevel,
    int? Function()? emergencyMonths,
  }) {
    return OnboardingAnswers(
      legalAccepted: legalAccepted ?? this.legalAccepted,
      ageRange: ageRange ?? this.ageRange,
      employment: employment ?? this.employment,
      monthlyIncomeCents: monthlyIncomeCents != null
          ? monthlyIncomeCents()
          : this.monthlyIncomeCents,
      hasDependents: hasDependents ?? this.hasDependents,
      hasHighInterestDebt: hasHighInterestDebt ?? this.hasHighInterestDebt,
      debtCents: debtCents != null ? debtCents() : this.debtCents,
      expenses: expenses ?? this.expenses,
      riskAnswers: riskAnswers ?? this.riskAnswers,
      wantsHousing: wantsHousing ?? this.wantsHousing,
      wantsRetirement: wantsRetirement ?? this.wantsRetirement,
      wantsCustom: wantsCustom ?? this.wantsCustom,
      customGoalName: customGoalName ?? this.customGoalName,
      knowledgeLevel: knowledgeLevel ?? this.knowledgeLevel,
      emergencyMonths: emergencyMonths != null
          ? emergencyMonths()
          : this.emergencyMonths,
    );
  }
}
