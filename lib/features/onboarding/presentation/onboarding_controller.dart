import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/onboarding_answers.dart';
import '../domain/profile_enums.dart';

part 'onboarding_controller.g.dart';

class OnboardingFlowState {
  const OnboardingFlowState({
    this.step = OnboardingStep.language,
    this.answers = const OnboardingAnswers(),
  });

  final OnboardingStep step;
  final OnboardingAnswers answers;

  bool get isFirst => step == OnboardingStep.values.first;
  bool get isLast => step == OnboardingStep.values.last;
  bool get canContinue => answers.isStepComplete(step);

  OnboardingFlowState copyWith({
    OnboardingStep? step,
    OnboardingAnswers? answers,
  }) => OnboardingFlowState(
    step: step ?? this.step,
    answers: answers ?? this.answers,
  );
}

/// Step navigation and answers of the onboarding questionnaire.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingFlowState build() => const OnboardingFlowState();

  /// Moves to the next step if the current one is complete.
  void next() {
    if (!state.canContinue || state.isLast) return;
    state = state.copyWith(step: OnboardingStep.values[state.step.index + 1]);
  }

  /// Moves to the previous step. Returns `false` on the first step.
  bool back() {
    if (state.isFirst) return false;
    state = state.copyWith(step: OnboardingStep.values[state.step.index - 1]);
    return true;
  }

  void update(OnboardingAnswers Function(OnboardingAnswers answers) change) {
    state = state.copyWith(answers: change(state.answers));
  }

  void setExpense(ExpenseCategory category, int? cents) => update(
    (a) => a.copyWith(expenses: {...a.expenses, category: cents ?? 0}),
  );

  void setRiskAnswer(int question, int points) => update(
    (a) => a.copyWith(
      riskAnswers: [
        for (var i = 0; i < a.riskAnswers.length; i++)
          i == question ? points : a.riskAnswers[i],
      ],
    ),
  );

  void setHighInterestDebt(bool value) => update(
    (a) => a.copyWith(
      hasHighInterestDebt: value,
      debtCents: value ? null : () => null,
    ),
  );
}
