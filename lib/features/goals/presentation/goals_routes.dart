import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../domain/goal_type.dart';
import 'goal_detail_screen.dart';
import 'goal_form_screen.dart';
import 'goals_screen.dart';

int? _goalId(GoRouterState state) =>
    int.tryParse(state.pathParameters['goalId'] ?? '');

GoalType? _type(GoRouterState state) {
  final value = state.pathParameters['type'];
  for (final type in GoalType.values) {
    // The emergency goal is only created by onboarding.
    if (type.dbValue == value && type != GoalType.emergency) return type;
  }
  return null;
}

/// Routes of the Goals tab.
final goalsRoute = GoRoute(
  path: Routes.goals,
  builder: (context, state) => const GoalsScreen(),
  routes: [
    GoRoute(
      path: 'new/:type',
      redirect: (context, state) => _type(state) == null ? Routes.goals : null,
      builder: (context, state) => GoalFormScreen.create(type: _type(state)!),
    ),
    GoRoute(
      path: ':goalId',
      redirect: (context, state) =>
          _goalId(state) == null ? Routes.goals : null,
      builder: (context, state) => GoalDetailScreen(goalId: _goalId(state)!),
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) =>
              GoalFormScreen.edit(goalId: _goalId(state)!),
        ),
      ],
    ),
  ],
);
