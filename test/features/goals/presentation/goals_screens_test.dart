import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/test_database.dart';

Future<void> _enter(WidgetTester tester, String label, String text) async {
  final field = find.widgetWithText(TextFormField, label);
  await tester.ensureVisible(field);
  await tester.enterText(field, text);
  await tester.pumpAndSettle();
}

Future<void> _save(WidgetTester tester) =>
    tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));

void main() {
  late AppDatabase db;
  late GoalsRepository goals;
  late InvestmentsRepository investments;

  setUp(() {
    db = createTestDatabase();
    goals = GoalsRepository(db.goalsDao);
    investments = InvestmentsRepository(db.investmentsDao);
  });

  /// Saved profile with 1.000 €/month of expenses and an emergency goal of
  /// 5 months, plus 2.000 € in an Emergency Fund asset.
  Future<void> seed(WidgetTester tester) => tester.runAsync(() async {
    final profiles = ProfileRepository(db.profileDao);
    await profiles.saveProfile(onboardedProfile());
    await profiles.replaceExpenses(const [
      MonthlyExpense(category: ExpenseCategory.housing, amountCents: 100000),
    ]);
    await goals.addGoal(
      Goal(
        type: GoalType.emergency,
        name: 'Fondo de emergencia',
        targetCents: 500000,
        createdAt: DateTime.utc(2026),
      ),
    );
    final savings = await investments.addAsset(
      testAsset(AssetCategory.emergency, name: 'Cuenta'),
    );
    await investments.addTransaction(
      testTx(savings, TransactionType.deposit, 200000),
    );
  });

  Future<void> openGoals(WidgetTester tester) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Objetivos').last);
  }

  testWidgets('lists goals with their progress', (tester) async {
    await seed(tester);
    await openGoals(tester);

    expect(find.text('Fondo de emergencia'), findsOneWidget);
    expect(findMoney('2.000,00 € de 5.000,00 €'), findsOneWidget);
    expect(findMoney('40 %'), findsOneWidget);
  });

  testWidgets('emergency detail shows plan, inputs and counted assets', (
    tester,
  ) async {
    await seed(tester);
    await openGoals(tester);
    await tapVisible(tester, find.text('Fondo de emergencia'));

    expect(find.text('Te falta'), findsOneWidget);
    expect(findMoney('3.000,00 €'), findsOneWidget);
    expect(find.text('Gastos mensuales'), findsOneWidget);
    expect(findMoney('1.000,00 €'), findsOneWidget);
    expect(find.text('Cuenta'), findsOneWidget);
    expect(find.byTooltip('Eliminar'), findsNothing);
  });

  testWidgets('creates a retirement goal with the 4% rule', (tester) async {
    await seed(tester);
    await openGoals(tester);
    await tapVisible(tester, find.byType(FloatingActionButton));
    await tapVisible(tester, find.text('Jubilación'));

    await _enter(tester, 'Edad actual', '30');
    await _enter(tester, 'Gasto mensual en la jubilación', '1500');
    expect(findMoney('450.000,00 €'), findsOneWidget);
    // Default expected return for retirement is 5 %.
    expect(find.widgetWithText(TextFormField, '5'), findsOneWidget);
    await _save(tester);

    await tapVisible(tester, find.text('Jubilación'));
    expect(find.text('Aportación mensual necesaria'), findsOneWidget);
    expect(find.text('Quedan 444 meses'), findsOneWidget);
    expect(
      find.text('Simulación orientativa, los resultados no están garantizados'),
      findsNWidgets(2),
    );
    expect(find.byType(LineChart), findsOneWidget);
    expect(find.text('Proyección hasta la jubilación'), findsOneWidget);
    expect(findMoney('Capital aportado: ', contains: true), findsOneWidget);

    final saved = (await tester.runAsync(goals.getGoals))!.last;
    expect(saved.type, GoalType.retirement);
    expect(saved.targetCents, 45000000);
    expect(saved.expectedAnnualReturn, closeTo(0.05, 1e-12));
    expect(saved.targetDate, isNotNull);
  });

  testWidgets('housing goal requires price and date', (tester) async {
    await seed(tester);
    await openGoals(tester);
    await tapVisible(tester, find.byType(FloatingActionButton));
    await tapVisible(tester, find.text('Entrada de una vivienda'));

    await _save(tester);
    expect(find.text('Introduce un importe válido'), findsOneWidget);
    expect(find.text('Campo obligatorio'), findsOneWidget);

    await _enter(tester, 'Precio de la vivienda', '200000');
    expect(findMoney('60.000,00 €'), findsOneWidget);

    await tapVisible(tester, find.text('Fecha objetivo'));
    await tapVisible(tester, find.byTooltip('Mes siguiente'));
    await tapVisible(tester, find.text('15'));
    await tapVisible(tester, find.text('ACEPTAR'));
    await _save(tester);

    expect(findMoney('0,00 € de 60.000,00 €'), findsOneWidget);
  });

  testWidgets('assigns an asset to a goal from its detail', (tester) async {
    await seed(tester);
    late int fundId;
    await tester.runAsync(() async {
      await goals.addGoal(
        Goal(
          type: GoalType.custom,
          name: 'Viaje',
          targetCents: 300000,
          createdAt: DateTime.utc(2026, 2),
        ),
      );
      fundId = await investments.addAsset(
        testAsset(AssetCategory.equity, name: 'Fondo global'),
      );
      await investments.addTransaction(
        testTx(fundId, TransactionType.buy, 150000, quantity: '10'),
      );
    });
    await openGoals(tester);
    await tapVisible(tester, find.text('Viaje'));
    expect(find.text('Todavía no hay activos asignados'), findsOneWidget);

    await tapVisible(tester, find.text('Asignar activos'));
    await tapVisible(
      tester,
      find.widgetWithText(CheckboxListTile, 'Fondo global'),
    );
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));

    expect(find.text('Fondo global'), findsOneWidget);
    expect(findMoney('1.500,00 € de 3.000,00 €'), findsOneWidget);
    final asset = await tester.runAsync(() => investments.getAsset(fundId));
    expect(asset!.goalId, isNotNull);
  });

  testWidgets('deletes a custom goal', (tester) async {
    await seed(tester);
    await tester.runAsync(
      () => goals.addGoal(
        Goal(
          type: GoalType.custom,
          name: 'Viaje',
          targetCents: 300000,
          createdAt: DateTime.utc(2026, 2),
        ),
      ),
    );
    await openGoals(tester);
    await tapVisible(tester, find.text('Viaje'));
    await tapVisible(tester, find.byTooltip('Editar objetivo'));
    await tapVisible(tester, find.byTooltip('Eliminar'));
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Eliminar'));

    expect(find.text('Viaje'), findsNothing);
    expect((await tester.runAsync(goals.getGoals))!, hasLength(1));
  });
}
