import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/json_columns.dart';
import '../domain/goal.dart';
import '../domain/goal_type.dart';
import 'goals_dao.dart';

part 'goals_repository.g.dart';

class GoalsRepository {
  const GoalsRepository(this._dao);

  final GoalsDao _dao;

  Future<List<Goal>> getGoals() async =>
      (await _dao.getGoals()).map((r) => r.toDomain()).toList();

  Stream<List<Goal>> watchGoals() =>
      _dao.watchGoals().map((rows) => rows.map((r) => r.toDomain()).toList());

  Future<Goal?> getGoal(int id) async => (await _dao.getGoal(id))?.toDomain();

  Stream<Goal?> watchGoal(int id) =>
      _dao.watchGoal(id).map((row) => row?.toDomain());

  Future<Goal?> getEmergencyGoal() async =>
      (await _dao.getFirstOfType(GoalType.emergency))?.toDomain();

  /// Inserts a new goal ([Goal.id] is ignored) and returns its id.
  Future<int> addGoal(Goal goal) => _dao.insertGoal(goal.toCompanion());

  /// Updates an existing goal; returns `false` if it does not exist.
  Future<bool> updateGoal(Goal goal) {
    final id = goal.id;
    if (id == null) throw ArgumentError('Cannot update a goal without id');
    return _dao.updateGoal(id, goal.toCompanion());
  }

  /// Deletes a goal. Assets assigned to it are unassigned, not deleted.
  Future<void> deleteGoal(int id) => _dao.deleteGoal(id);
}

@Riverpod(keepAlive: true)
GoalsRepository goalsRepository(Ref ref) =>
    GoalsRepository(ref.watch(appDatabaseProvider).goalsDao);

extension on GoalRow {
  Goal toDomain() => Goal(
    id: id,
    type: type,
    name: name,
    targetCents: targetCents,
    targetDate: targetDate,
    expectedAnnualReturn: expectedAnnualReturn,
    params: decodeJsonMap(paramsJson),
    createdAt: createdAt,
  );
}

extension on Goal {
  GoalsCompanion toCompanion() => GoalsCompanion.insert(
    type: type,
    name: name,
    targetCents: targetCents,
    targetDate: Value(targetDate?.toUtc()),
    expectedAnnualReturn: Value(expectedAnnualReturn),
    paramsJson: Value(encodeJsonMap(params)),
    createdAt: createdAt.toUtc(),
  );
}
