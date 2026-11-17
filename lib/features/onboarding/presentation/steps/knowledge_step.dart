import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/profile_enums.dart';
import '../onboarding_controller.dart';
import '../onboarding_labels.dart';
import '../../../../core/widgets/option_tile.dart';
import '../widgets/step_layout.dart';

/// Step 6: prior investing knowledge.
class KnowledgeStep extends ConsumerWidget {
  const KnowledgeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final selected = ref.watch(
      onboardingControllerProvider.select((s) => s.answers.knowledgeLevel),
    );
    final controller = ref.read(onboardingControllerProvider.notifier);

    return StepLayout(
      title: l10n.onboardingKnowledgeTitle,
      children: [
        for (final level in KnowledgeLevel.values)
          OptionTile(
            label: l10n.knowledgeLevel(level),
            selected: selected == level,
            onTap: () =>
                controller.update((a) => a.copyWith(knowledgeLevel: level)),
          ),
      ],
    );
  }
}
