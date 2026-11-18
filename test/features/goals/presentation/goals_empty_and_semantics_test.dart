import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  testWidgets('goals tab shows an empty state', (tester) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Objetivos').last);

    expect(find.text('Aún no tienes objetivos'), findsOneWidget);
    await tapVisible(
      tester,
      find.widgetWithText(OutlinedButton, 'Nuevo objetivo'),
    );
    expect(find.text('Jubilación'), findsOneWidget);
  });

  testWidgets('goal progress is announced to screen readers', (tester) async {
    await tester.runAsync(() async {
      await GoalsRepository(db.goalsDao).addGoal(
        Goal(
          type: GoalType.emergency,
          name: 'Fondo',
          targetCents: 500000,
          createdAt: DateTime.utc(2026),
        ),
      );
      final repo = InvestmentsRepository(db.investmentsDao);
      final id = await repo.addAsset(testAsset(AssetCategory.emergency));
      await repo.addTransaction(testTx(id, TransactionType.deposit, 200000));
    });
    final handle = tester.ensureSemantics();
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Objetivos').last);

    // The tappable card merges its content into one node, which includes
    // the progress bar label.
    expect(find.bySemanticsLabel(RegExp('Progreso de Fondo')), findsOneWidget);
    handle.dispose();
  });
}
