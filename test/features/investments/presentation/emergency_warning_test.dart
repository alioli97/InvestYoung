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

const _warning = 'Tu fondo de emergencia aún no está completo';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  Future<void> seed(WidgetTester tester, {required int savingsCents}) =>
      tester.runAsync(() async {
        await GoalsRepository(db.goalsDao).addGoal(
          Goal(
            type: GoalType.emergency,
            name: 'Fondo de emergencia',
            targetCents: 500000,
            createdAt: DateTime.utc(2026),
          ),
        );
        final repo = InvestmentsRepository(db.investmentsDao);
        final id = await repo.addAsset(testAsset(AssetCategory.emergency));
        await repo.addTransaction(
          testTx(id, TransactionType.deposit, savingsCents),
        );
      });

  Future<void> openNewAsset(WidgetTester tester, String category) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Inversiones').last);
    await tapVisible(tester, find.text(category));
    await tapVisible(tester, find.byType(FloatingActionButton));
  }

  for (final category in ['Renta variable', 'Criptomonedas']) {
    testWidgets('warns before adding $category with an incomplete fund', (
      tester,
    ) async {
      await seed(tester, savingsCents: 200000);
      await openNewAsset(tester, category);

      expect(findMoney(_warning, contains: true), findsOneWidget);
      expect(
        findMoney('(2.000,00 € de 5.000,00 €)', contains: true),
        findsOneWidget,
      );

      // Non-blocking: the asset can still be saved.
      await tester.enterText(find.widgetWithText(TextFormField, 'Nombre'), 'X');
      await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));
      expect(find.text('X'), findsOneWidget);
    });
  }

  testWidgets('no warning once the emergency fund is complete', (tester) async {
    await seed(tester, savingsCents: 500000);
    await openNewAsset(tester, 'Renta variable');
    expect(findMoney(_warning, contains: true), findsNothing);
  });

  testWidgets('no warning for lower-risk categories', (tester) async {
    await seed(tester, savingsCents: 0);
    await openNewAsset(tester, 'Renta fija');
    expect(findMoney(_warning, contains: true), findsNothing);
  });
}
