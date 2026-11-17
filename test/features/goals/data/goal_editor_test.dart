import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goal_editor.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late GoalsRepository goals;
  late ProfileRepository profiles;
  late GoalEditor editor;

  setUp(() async {
    db = createTestDatabase();
    goals = GoalsRepository(db.goalsDao);
    profiles = ProfileRepository(db.profileDao);
    editor = GoalEditor(db, goals, profiles);
    await profiles.saveProfile(onboardedProfile());
  });

  tearDown(() => db.close());

  test('saving the emergency goal syncs the profile months', () async {
    await editor.save(
      Goal(
        type: GoalType.emergency,
        name: 'Fondo',
        targetCents: 800000,
        params: const {'months': 8},
        createdAt: DateTime.utc(2026),
      ),
    );
    expect((await profiles.getProfile())!.emergencyMonths, 8);
  });

  test('other goals do not touch the profile', () async {
    await editor.save(
      Goal(
        type: GoalType.custom,
        name: 'Viaje',
        targetCents: 200000,
        params: const {'months': 11},
        createdAt: DateTime.utc(2026),
      ),
    );
    expect((await profiles.getProfile())!.emergencyMonths, 5);
  });

  test('updates existing goals and deletes them', () async {
    await editor.save(
      Goal(
        type: GoalType.custom,
        name: 'Viaje',
        targetCents: 1,
        createdAt: DateTime.utc(2026),
      ),
    );
    final saved = (await goals.getGoals()).single;
    await editor.save(saved.copyWith(targetCents: 500));
    expect((await goals.getGoals()).single.targetCents, 500);

    await editor.delete(saved.id!);
    expect(await goals.getGoals(), isEmpty);
  });
}
