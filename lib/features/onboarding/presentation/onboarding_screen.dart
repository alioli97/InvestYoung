import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import 'onboarding_status_provider.dart';

/// Entry point of the onboarding flow. Placeholder until Phase 2.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(l10n.appTitle, style: textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(l10n.onboardingWelcomeTitle, style: textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(l10n.onboardingWelcomeBody, style: textTheme.bodyLarge),
              const Spacer(),
              FilledButton(
                onPressed: () =>
                    ref.read(onboardingStatusProvider.notifier).markCompleted(),
                child: Text(l10n.onboardingStartButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
