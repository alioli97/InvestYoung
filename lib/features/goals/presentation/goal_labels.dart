import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/goal.dart';
import '../domain/goal_type.dart';

extension GoalLabels on AppLocalizations {
  /// Default name of a new goal of [type].
  String goalTypeName(GoalType type) => switch (type) {
    GoalType.emergency => onboardingGoalEmergency,
    GoalType.housing => onboardingGoalHousing,
    GoalType.retirement => onboardingGoalRetirement,
    GoalType.custom => goalsCustomGoal,
  };

  /// Name to show for [goal] in the current language.
  ///
  /// Goals are saved with the default name of their type in the language
  /// active when they were created (e.g. "Fons d'emergència" after a Catalan
  /// onboarding). A goal that still has a default name, in any supported
  /// language, shows the default name of the current one; names typed by the
  /// user are shown as they are.
  String goalName(Goal goal) =>
      isDefaultGoalName(goal) ? goalTypeName(goal.type) : goal.name;
}

/// Whether [goal] still has the default name of its type in some supported
/// language.
bool isDefaultGoalName(Goal goal) => AppLocalizations.supportedLocales.any(
  (locale) =>
      lookupAppLocalizations(locale).goalTypeName(goal.type) == goal.name,
);

IconData goalIcon(GoalType type) => switch (type) {
  GoalType.emergency => Icons.health_and_safety_outlined,
  GoalType.housing => Icons.home_outlined,
  GoalType.retirement => Icons.beach_access_outlined,
  GoalType.custom => Icons.flag_outlined,
};
