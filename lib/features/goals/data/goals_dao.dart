import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';
import '../domain/goal_type.dart';

part 'goals_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.attachedDatabase);

  SimpleSelectStatement<$GoalsTable, GoalRow> _all() =>
      select(goals)..orderBy([(g) => OrderingTerm.asc(g.createdAt)]);

  Future<List<GoalRow>> getGoals() => _all().get();

  Stream<List<GoalRow>> watchGoals() => _all().watch();

  Future<GoalRow?> getGoal(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingleOrNull();

  Stream<GoalRow?> watchGoal(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).watchSingleOrNull();

  /// First goal of [type] (there is at most one emergency goal).
  Future<GoalRow?> getFirstOfType(GoalType type) =>
      (select(goals)
            ..where((g) => g.type.equalsValue(type))
            ..orderBy([(g) => OrderingTerm.asc(g.id)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertGoal(GoalsCompanion goal) => into(goals).insert(goal);

  Future<bool> updateGoal(int id, GoalsCompanion goal) async {
    final count = await (update(
      goals,
    )..where((g) => g.id.equals(id))).write(goal);
    return count > 0;
  }

  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();
}
