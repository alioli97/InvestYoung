import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_answers.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/presentation/onboarding_controller.dart';

void main() {
  late ProviderContainer container;
  late OnboardingController controller;

  OnboardingFlowState state() => container.read(onboardingControllerProvider);

  setUp(() {
    container = ProviderContainer();
    // Keep the auto-dispose provider alive during the test.
    container.listen(onboardingControllerProvider, (_, _) {});
    controller = container.read(onboardingControllerProvider.notifier);
  });

  tearDown(() => container.dispose());

  test('starts on the language step', () {
    expect(state().step, OnboardingStep.language);
    expect(state().isFirst, isTrue);
    expect(controller.back(), isFalse);
  });

  test('cannot skip an incomplete step', () {
    controller.next();
    expect(state().step, OnboardingStep.welcome);

    controller.next();
    expect(state().step, OnboardingStep.welcome);

    controller.update((a) => a.copyWith(legalAccepted: true));
    controller.next();
    expect(state().step, OnboardingStep.situation);

    expect(controller.back(), isTrue);
    expect(state().step, OnboardingStep.welcome);
  });

  test('setExpense and setRiskAnswer update single entries', () {
    controller.setExpense(ExpenseCategory.food, 20000);
    controller.setExpense(ExpenseCategory.transport, 3000);
    controller.setExpense(ExpenseCategory.food, null);
    expect(state().answers.expenses, {
      ExpenseCategory.food: 0,
      ExpenseCategory.transport: 3000,
    });

    controller.setRiskAnswer(2, 3);
    expect(state().answers.riskAnswers, [null, null, 3, null]);
  });

  test('answering no to debt clears the debt amount', () {
    controller.setHighInterestDebt(true);
    controller.update((a) => a.copyWith(debtCents: () => 50000));
    controller.setHighInterestDebt(true);
    expect(state().answers.debtCents, 50000);

    controller.setHighInterestDebt(false);
    expect(state().answers.hasHighInterestDebt, isFalse);
    expect(state().answers.debtCents, isNull);
  });
}
