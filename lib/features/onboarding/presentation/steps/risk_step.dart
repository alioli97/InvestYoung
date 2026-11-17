import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/onboarding_logic.dart';
import '../onboarding_controller.dart';
import '../onboarding_labels.dart';
import '../widgets/option_tile.dart';
import '../widgets/step_layout.dart';

/// Step 4: four risk tolerance questions, each answer worth 1–3 points.
class RiskStep extends ConsumerWidget {
  const RiskStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answers = ref.watch(
      onboardingControllerProvider.select((s) => s.answers.riskAnswers),
    );
    final controller = ref.read(onboardingControllerProvider.notifier);

    return StepLayout(
      title: l10n.onboardingRiskTitle,
      children: [
        for (var q = 0; q < riskQuestionCount; q++) ...[
          StepSectionLabel(l10n.riskQuestion(q).$1),
          for (final (i, label) in l10n.riskQuestion(q).$2.indexed)
            OptionTile(
              label: label,
              selected: answers[q] == i + 1,
              onTap: () => controller.setRiskAnswer(q, i + 1),
            ),
        ],
      ],
    );
  }
}
