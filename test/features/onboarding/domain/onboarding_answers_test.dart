import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_answers.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_logic.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';

const _complete = OnboardingAnswers(
  legalAccepted: true,
  ageRange: AgeRange.from21To25,
  employment: Employment.permanent,
  hasDependents: false,
  hasHighInterestDebt: false,
  expenses: {ExpenseCategory.housing: 60000, ExpenseCategory.food: 25000},
  riskAnswers: [2, 2, 2, 2],
  knowledgeLevel: KnowledgeLevel.basic,
);

void main() {
  test('total expenses sums every category', () {
    expect(_complete.totalExpensesCents, 85000);
    expect(const OnboardingAnswers().totalExpensesCents, 0);
  });

  test('risk profile is null until every question is answered', () {
    const partial = OnboardingAnswers(riskAnswers: [3, 3, null, 3]);
    expect(partial.riskProfile, isNull);
    expect(_complete.riskScoreValue, 8);
    expect(_complete.riskProfile, RiskProfile.moderate);
  });

  test('emergency months default to the range midpoint and are clamped', () {
    expect(_complete.emergencyRange, EmergencyMonthsRange.standard);
    expect(_complete.selectedEmergencyMonths, 5);
    expect(_complete.emergencyTargetCents, 425000);

    final chosen = _complete.copyWith(emergencyMonths: () => 20);
    expect(chosen.selectedEmergencyMonths, 6);
  });

  test('copyWith can clear nullable fields', () {
    final withDebt = _complete.copyWith(debtCents: () => 1000);
    expect(withDebt.debtCents, 1000);
    expect(withDebt.copyWith(debtCents: () => null).debtCents, isNull);
    expect(withDebt.copyWith(legalAccepted: false).debtCents, 1000);
  });

  group('isStepComplete', () {
    test('welcome requires accepting the legal notice', () {
      expect(
        const OnboardingAnswers().isStepComplete(OnboardingStep.welcome),
        isFalse,
      );
      expect(_complete.isStepComplete(OnboardingStep.welcome), isTrue);
    });

    test('situation requires the mandatory answers only', () {
      const answers = OnboardingAnswers(
        ageRange: AgeRange.over35,
        employment: Employment.student,
        hasDependents: true,
      );
      expect(answers.isStepComplete(OnboardingStep.situation), isFalse);
      expect(
        answers
            .copyWith(hasHighInterestDebt: false)
            .isStepComplete(OnboardingStep.situation),
        isTrue,
      );
    });

    test('expenses can all be zero', () {
      expect(
        const OnboardingAnswers().isStepComplete(OnboardingStep.expenses),
        isTrue,
      );
    });

    test('a custom goal needs a name', () {
      final custom = _complete.copyWith(wantsCustom: true);
      expect(custom.isStepComplete(OnboardingStep.goals), isFalse);
      expect(
        custom
            .copyWith(customGoalName: '  ')
            .isStepComplete(OnboardingStep.goals),
        isFalse,
      );
      expect(
        custom
            .copyWith(customGoalName: 'Viaje')
            .isStepComplete(OnboardingStep.goals),
        isTrue,
      );
    });

    test('result requires every previous step', () {
      expect(_complete.isStepComplete(OnboardingStep.result), isTrue);
      expect(
        const OnboardingAnswers().isStepComplete(OnboardingStep.result),
        isFalse,
      );
    });
  });
}
