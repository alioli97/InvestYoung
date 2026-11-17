import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/onboarding_answers.dart';
import 'onboarding_controller.dart';
import 'onboarding_status_provider.dart';
import 'steps/expenses_step.dart';
import 'steps/goals_step.dart';
import 'steps/knowledge_step.dart';
import 'steps/language_step.dart';
import 'steps/result_step.dart';
import 'steps/risk_step.dart';
import 'steps/situation_step.dart';
import 'steps/welcome_step.dart';

/// Onboarding questionnaire: one step per screen with progress and Back.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final total = OnboardingStep.values.length;
    final current = flow.step.index + 1;

    return PopScope(
      canPop: flow.isFirst,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) controller.back();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(context.l10n.onboardingStepCounter(current, total)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(value: current / total),
          ),
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: KeyedSubtree(
              key: ValueKey(flow.step),
              child: _stepBody(flow.step),
            ),
          ),
        ),
        bottomNavigationBar: _NavigationButtons(
          flow: flow,
          onBack: controller.back,
          onNext: controller.next,
          onConfirm: () => _confirm(context, ref),
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(onboardingControllerProvider.notifier)
          .confirm(
            locale: Localizations.localeOf(context).languageCode,
            names: (
              emergency: l10n.onboardingGoalEmergency,
              housing: l10n.onboardingGoalHousing,
              retirement: l10n.onboardingGoalRetirement,
            ),
          );
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.commonSaveError)));
      return;
    }
    ref.read(onboardingStatusProvider.notifier).markCompleted();
  }

  static Widget _stepBody(OnboardingStep step) => switch (step) {
    OnboardingStep.language => const LanguageStep(),
    OnboardingStep.welcome => const WelcomeStep(),
    OnboardingStep.situation => const SituationStep(),
    OnboardingStep.expenses => const ExpensesStep(),
    OnboardingStep.risk => const RiskStep(),
    OnboardingStep.goals => const GoalsStep(),
    OnboardingStep.knowledge => const KnowledgeStep(),
    OnboardingStep.result => const ResultStep(),
  };
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({
    required this.flow,
    required this.onBack,
    required this.onNext,
    required this.onConfirm,
  });

  final OnboardingFlowState flow;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            if (!flow.isFirst)
              TextButton(onPressed: onBack, child: Text(l10n.commonBack)),
            const SizedBox(width: 8),
            // Expanded + Align lets long labels wrap on narrow screens or
            // with large text instead of overflowing.
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                heightFactor: 1,
                child: FilledButton(
                  onPressed: flow.canContinue
                      ? (flow.isLast ? onConfirm : onNext)
                      : null,
                  child: Text(
                    flow.isLast ? l10n.onboardingConfirm : l10n.commonContinue,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
