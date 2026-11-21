import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/goals/presentation/goal_labels.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/test_database.dart';

Goal _goal(GoalType type, String name) => Goal(
  type: type,
  name: name,
  targetCents: 100000,
  createdAt: DateTime.utc(2026),
);

void main() {
  group('goalName', () {
    final es = lookupAppLocalizations(const Locale('es'));
    final ca = lookupAppLocalizations(const Locale('ca'));

    test('default names follow the current language', () {
      final emergency = _goal(GoalType.emergency, "Fons d'emergència");
      final housing = _goal(GoalType.housing, "Entrada d'un habitatge");

      expect(es.goalName(emergency), 'Fondo de emergencia');
      expect(es.goalName(housing), 'Entrada de una vivienda');
      expect(
        ca.goalName(_goal(GoalType.retirement, 'Jubilación')),
        'Jubilació',
      );
    });

    test('names typed by the user are kept', () {
      expect(
        es.goalName(_goal(GoalType.housing, 'Piso en Girona')),
        'Piso en Girona',
      );
      // The default name of another type is a user choice too.
      expect(
        es.goalName(_goal(GoalType.custom, "Fons d'emergència")),
        "Fons d'emergència",
      );
    });
  });

  testWidgets('goals created in Catalan show Spanish names in Spanish', (
    tester,
  ) async {
    final AppDatabase db = createTestDatabase();
    await tester.runAsync(() async {
      await ProfileRepository(db.profileDao).saveProfile(onboardedProfile());
      final goals = GoalsRepository(db.goalsDao);
      await goals.addGoal(_goal(GoalType.emergency, "Fons d'emergència"));
      await goals.addGoal(_goal(GoalType.housing, "Entrada d'un habitatge"));
      await goals.addGoal(_goal(GoalType.custom, 'Viatge al Japó'));
    });

    await pumpApp(tester, database: db, startupProfile: onboardedProfile());

    expect(find.text("Fons d'emergència"), findsNothing);
    expect(find.text("Entrada d'un habitatge"), findsNothing);

    await tapVisible(tester, find.text('Objetivos').last);

    expect(find.text('Fondo de emergencia'), findsOneWidget);
    expect(find.text('Entrada de una vivienda'), findsOneWidget);
    expect(find.text('Viatge al Japó'), findsOneWidget);
  });
}
