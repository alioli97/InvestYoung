import '../../../core/l10n/l10n.dart';
import '../domain/onboarding_logic.dart';
import '../domain/profile_enums.dart';

/// Localized labels for onboarding enums.
extension OnboardingLabels on AppLocalizations {
  String ageRange(AgeRange value) => switch (value) {
    AgeRange.from16To20 => onboardingAge16To20,
    AgeRange.from21To25 => onboardingAge21To25,
    AgeRange.from26To30 => onboardingAge26To30,
    AgeRange.from31To35 => onboardingAge31To35,
    AgeRange.over35 => onboardingAgeOver35,
  };

  String employment(Employment value) => switch (value) {
    Employment.permanent => onboardingEmploymentPermanent,
    Employment.temporary => onboardingEmploymentTemporary,
    Employment.selfEmployed => onboardingEmploymentSelfEmployed,
    Employment.student => onboardingEmploymentStudent,
    Employment.unemployed => onboardingEmploymentUnemployed,
  };

  String expenseCategory(ExpenseCategory value) => switch (value) {
    ExpenseCategory.housing => onboardingExpenseHousing,
    ExpenseCategory.food => onboardingExpenseFood,
    ExpenseCategory.transport => onboardingExpenseTransport,
    ExpenseCategory.insurance => onboardingExpenseInsurance,
    ExpenseCategory.subscriptions => onboardingExpenseSubscriptions,
    ExpenseCategory.otherFixed => onboardingExpenseOtherFixed,
  };

  String knowledgeLevel(KnowledgeLevel value) => switch (value) {
    KnowledgeLevel.none => onboardingKnowledgeNone,
    KnowledgeLevel.basic => onboardingKnowledgeBasic,
    KnowledgeLevel.intermediate => onboardingKnowledgeIntermediate,
  };

  String riskProfile(RiskProfile value) => switch (value) {
    RiskProfile.conservative => onboardingRiskProfileConservative,
    RiskProfile.moderate => onboardingRiskProfileModerate,
    RiskProfile.aggressive => onboardingRiskProfileAggressive,
  };

  String riskProfileDescription(RiskProfile value) => switch (value) {
    RiskProfile.conservative => onboardingRiskProfileConservativeDesc,
    RiskProfile.moderate => onboardingRiskProfileModerateDesc,
    RiskProfile.aggressive => onboardingRiskProfileAggressiveDesc,
  };

  String learnModule(LearnModule value) => switch (value) {
    LearnModule.fundamentals => learnModuleFundamentals,
    LearnModule.emergencyFund => learnModuleEmergencyFund,
    LearnModule.debt => learnModuleDebt,
    LearnModule.fixedIncome => learnModuleFixedIncome,
    LearnModule.equities => learnModuleEquities,
    LearnModule.crypto => learnModuleCrypto,
    LearnModule.taxes => learnModuleTaxes,
    LearnModule.psychology => learnModulePsychology,
  };

  /// Question text and its 3 answers (worth 1, 2 and 3 points).
  (String, List<String>) riskQuestion(int index) => switch (index) {
    0 => (
      onboardingRiskQ1,
      [onboardingRiskQ1A1, onboardingRiskQ1A2, onboardingRiskQ1A3],
    ),
    1 => (
      onboardingRiskQ2,
      [onboardingRiskQ2A1, onboardingRiskQ2A2, onboardingRiskQ2A3],
    ),
    2 => (
      onboardingRiskQ3,
      [onboardingRiskQ3A1, onboardingRiskQ3A2, onboardingRiskQ3A3],
    ),
    3 => (
      onboardingRiskQ4,
      [onboardingRiskQ4A1, onboardingRiskQ4A2, onboardingRiskQ4A3],
    ),
    _ => throw RangeError.index(index, riskQuestionCount),
  };
}
