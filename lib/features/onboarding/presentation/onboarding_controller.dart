import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/onboarding_repository.dart';
import '../domain/onboarding_answers.dart';
import '../domain/profile_enums.dart';

part 'onboarding_controller.g.dart';

class OnboardingFlowState {
  const OnboardingFlowState({
    this.step = OnboardingStep.language,
    this.answers = const OnboardingAnswers(),
    this.saving = false,
  });

  final OnboardingStep step;
  final OnboardingAnswers answers;

  /// `true` while the result is being persisted.
  final bool saving;

  bool get isFirst => step == OnboardingStep.values.first;
  bool get isLast => step == OnboardingStep.values.last;
  bool get canContinue => !saving && answers.isStepComplete(step);

  OnboardingFlowState copyWith({
    OnboardingStep? step,
    OnboardingAnswers? answers,
    bool? saving,
  }) => OnboardingFlowState(
    step: step ?? this.step,
    answers: answers ?? this.answers,
    saving: saving ?? this.saving,
  );
}

/// Step navigation and answers of the onboarding questionnaire.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingFlowState build() => const OnboardingFlowState();

  /// Restarts the flow from the first step with [answers] prefilled.
  void start(OnboardingAnswers answers) =>
      state = OnboardingFlowState(answers: answers);

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

  /// Persists the answers. Throws if saving fails (state stays editable).
  Future<void> confirm({
    required String locale,
    required OnboardingGoalNames names,
  }) async {
    if (!state.isLast || !state.canContinue) return;
    state = state.copyWith(saving: true);
    try {
      await ref
          .read(onboardingRepositoryProvider)
          .complete(state.answers, locale: locale, names: names);
    } finally {
      if (ref.mounted) state = state.copyWith(saving: false);
    }
  }

  void setHighInterestDebt(bool value) => update(
    (a) => a.copyWith(
      hasHighInterestDebt: value,
      debtCents: value ? null : () => null,
    ),
  );
}
