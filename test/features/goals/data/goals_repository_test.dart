import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';

import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late GoalsRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = GoalsRepository(db.goalsDao);
  });

  tearDown(() => db.close());

  Goal housing({int? id, int targetCents = 6000000}) => Goal(
    id: id,
    type: GoalType.housing,
    name: 'Piso',
    targetCents: targetCents,
    targetDate: DateTime.utc(2030, 6, 1),
    expectedAnnualReturn: 0.03,
    params: const {'homePriceCents': 20000000, 'downPaymentPct': 0.2},
    createdAt: DateTime.utc(2026, 1, 2),
  );

  test('adds and reads goals with JSON params', () async {
    final id = await repo.addGoal(housing());
    final goal = await repo.getGoal(id);

    expect(goal!.type, GoalType.housing);
    expect(goal.expectedAnnualReturn, 0.03);
    expect(goal.params['homePriceCents'], 20000000);
    expect(goal.params['downPaymentPct'], 0.2);
    expect(goal.targetDate, DateTime.utc(2030, 6, 1));
  });

  test('finds the emergency goal', () async {
    await repo.addGoal(housing());
    expect(await repo.getEmergencyGoal(), isNull);

    await repo.addGoal(
      Goal(
        type: GoalType.emergency,
        name: 'Fondo',
        targetCents: 500000,
        createdAt: DateTime.utc(2026, 1, 3),
      ),
    );
    final emergency = await repo.getEmergencyGoal();
    expect(emergency!.name, 'Fondo');
    expect(emergency.params, isEmpty);
  });

  test('updates and deletes goals', () async {
    final id = await repo.addGoal(housing());
    expect(await repo.updateGoal(housing(id: id, targetCents: 1)), isTrue);
    expect((await repo.getGoal(id))!.targetCents, 1);

    await repo.deleteGoal(id);
    expect(await repo.getGoals(), isEmpty);
    expect(await repo.updateGoal(housing(id: id)), isFalse);
  });

  test('updating a goal without id throws', () {
    expect(() => repo.updateGoal(housing()), throwsArgumentError);
  });
}
