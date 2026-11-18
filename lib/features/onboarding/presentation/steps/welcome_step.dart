import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/legal_notice_card.dart';
import '../onboarding_controller.dart';
import '../widgets/step_layout.dart';

/// Step 1: welcome and legal notice, which must be accepted.
class WelcomeStep extends ConsumerWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final accepted = ref.watch(
      onboardingControllerProvider.select((s) => s.answers.legalAccepted),
    );

    return StepLayout(
      title: l10n.onboardingWelcomeTitle,
      subtitle: l10n.onboardingWelcomeBody,
      children: [
        const LegalNoticeCard(),
        const SizedBox(height: 8),
        CheckboxListTile(
          value: accepted,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(l10n.onboardingLegalAccept),
          onChanged: (value) => ref
              .read(onboardingControllerProvider.notifier)
              .update((a) => a.copyWith(legalAccepted: value ?? false)),
        ),
      ],
    );
  }
}
