import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../goals/data/goals_repository.dart';
import '../data/profile_repository.dart';
import '../domain/onboarding_answers.dart';
import 'onboarding_controller.dart';
import 'onboarding_screen.dart';

/// Loads the saved answers and opens the questionnaire prefilled with them.
class RetakeOnboardingScreen extends ConsumerStatefulWidget {
  const RetakeOnboardingScreen({super.key});

  @override
  ConsumerState<RetakeOnboardingScreen> createState() =>
      _RetakeOnboardingScreenState();
}

class _RetakeOnboardingScreenState
    extends ConsumerState<RetakeOnboardingScreen> {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final profiles = ref.read(profileRepositoryProvider);
    final profile = await profiles.getProfile();
    final expenses = await profiles.getExpenses();
    final goals = await ref.read(goalsRepositoryProvider).getGoals();
    if (!mounted) return;

    ref
        .read(onboardingControllerProvider.notifier)
        .start(
          profile == null
              ? const OnboardingAnswers()
              : OnboardingAnswers.fromSaved(
                  profile: profile,
                  expenses: expenses,
                  goals: goals,
                ),
        );
    setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    // Keeps the auto-dispose controller alive while the data loads.
    ref.watch(onboardingControllerProvider);
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return const OnboardingScreen(retake: true);
  }
}
