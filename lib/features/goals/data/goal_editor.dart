import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../../onboarding/data/profile_repository.dart';
import '../domain/goal.dart';
import '../domain/goal_params.dart';
import '../domain/goal_type.dart';
import 'goals_repository.dart';

part 'goal_editor.g.dart';

/// Saves goals, keeping the profile's emergency months in sync.
class GoalEditor {
  const GoalEditor(this._db, this._goals, this._profiles);

  final AppDatabase _db;
  final GoalsRepository _goals;
  final ProfileRepository _profiles;

  /// Creates [goal] (no id) or updates it.
  Future<void> save(Goal goal) => _db.transaction(() async {
    if (goal.id == null) {
      await _goals.addGoal(goal);
    } else {
      await _goals.updateGoal(goal);
    }
    final months = GoalParams.intValue(goal.params, GoalParams.months);
    if (goal.type == GoalType.emergency && months != null) {
      final profile = await _profiles.getProfile();
      if (profile != null && profile.emergencyMonths != months) {
        await _profiles.saveProfile(profile.withEmergencyMonths(months));
      }
    }
  });

  /// Deletes a goal; its assets are unassigned, never deleted.
  Future<void> delete(int goalId) => _goals.deleteGoal(goalId);
}

@Riverpod(keepAlive: true)
GoalEditor goalEditor(Ref ref) => GoalEditor(
  ref.watch(appDatabaseProvider),
  ref.watch(goalsRepositoryProvider),
  ref.watch(profileRepositoryProvider),
);
