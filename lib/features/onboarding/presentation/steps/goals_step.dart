import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../onboarding_controller.dart';
import '../widgets/step_layout.dart';

/// Step 5: goals. The emergency fund is always selected.
class GoalsStep extends ConsumerStatefulWidget {
  const GoalsStep({super.key});

  @override
  ConsumerState<GoalsStep> createState() => _GoalsStepState();
}

class _GoalsStepState extends ConsumerState<GoalsStep> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: ref.read(onboardingControllerProvider).answers.customGoalName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final answers = ref.watch(onboardingControllerProvider).answers;
    final controller = ref.read(onboardingControllerProvider.notifier);

    Widget goal(String title, bool value, ValueChanged<bool> onChanged) =>
        CheckboxListTile(
          value: value,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(title),
          onChanged: (v) => onChanged(v ?? false),
        );

    return StepLayout(
      title: l10n.onboardingGoalsTitle,
      subtitle: l10n.onboardingGoalsSubtitle,
      children: [
        CheckboxListTile(
          value: true,
          onChanged: null,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(l10n.onboardingGoalEmergency),
          subtitle: Text(l10n.onboardingGoalEmergencyHint),
        ),
        goal(
          l10n.onboardingGoalHousing,
          answers.wantsHousing,
          (v) => controller.update((a) => a.copyWith(wantsHousing: v)),
        ),
        goal(
          l10n.onboardingGoalRetirement,
          answers.wantsRetirement,
          (v) => controller.update((a) => a.copyWith(wantsRetirement: v)),
        ),
        goal(
          l10n.onboardingGoalOther,
          answers.wantsCustom,
          (v) => controller.update((a) => a.copyWith(wantsCustom: v)),
        ),
        if (answers.wantsCustom)
          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 40,
            decoration: InputDecoration(
              labelText: l10n.onboardingGoalOtherName,
            ),
            onChanged: (name) =>
                controller.update((a) => a.copyWith(customGoalName: name)),
          ),
      ],
    );
  }
}
