import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../domain/goal_type.dart';

extension GoalLabels on AppLocalizations {
  /// Default name of a new goal of [type].
  String goalTypeName(GoalType type) => switch (type) {
    GoalType.emergency => onboardingGoalEmergency,
    GoalType.housing => onboardingGoalHousing,
    GoalType.retirement => onboardingGoalRetirement,
    GoalType.custom => goalsCustomGoal,
  };
}

IconData goalIcon(GoalType type) => switch (type) {
  GoalType.emergency => Icons.health_and_safety_outlined,
  GoalType.housing => Icons.home_outlined,
  GoalType.retirement => Icons.beach_access_outlined,
  GoalType.custom => Icons.flag_outlined,
};
