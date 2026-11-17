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

Future<void> _openCategory(WidgetTester tester, String name) async {
  await tapVisible(tester, find.text('Inversiones').last);
  await tapVisible(tester, find.text(name));
}

Future<void> _enter(WidgetTester tester, String label, String text) async {
  final field = find.widgetWithText(TextFormField, label);
  await tester.ensureVisible(field);
  await tester.enterText(field, text);
  await tester.pumpAndSettle();
}

void main() {
  late AppDatabase db;
  late InvestmentsRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = InvestmentsRepository(db.investmentsDao);
  });

  testWidgets('empty category offers to add an asset', (tester) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await _openCategory(tester, 'Criptomonedas');

    expect(find.text('Aún no tienes nada en esta categoría'), findsOneWidget);
    expect(find.text('Añadir activo'), findsNWidgets(2));
  });

  testWidgets('creates a crypto asset with its specific fields', (
    tester,
  ) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await _openCategory(tester, 'Criptomonedas');
    await tapVisible(tester, find.byType(FloatingActionButton));

    expect(find.text('Nuevo activo'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Símbolo'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Ticker o ISIN'), findsNothing);

    // Name is required.
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));
    expect(find.text('Campo obligatorio'), findsOneWidget);

    await _enter(tester, 'Nombre', 'Bitcoin');
    await _enter(tester, 'Símbolo', 'btc');
    await _enter(tester, 'Exchange o wallet', 'Hardware wallet');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));

    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('BTC · Hardware wallet'), findsOneWidget);

    final asset = (await tester.runAsync(repo.getAssets))!.single;
    expect(asset.category, AssetCategory.crypto);
    expect(asset.metadata, {'symbol': 'BTC', 'exchange': 'Hardware wallet'});
    expect(asset.goalId, isNull);
  });

  testWidgets('creates an emergency asset with APY and a goal', (tester) async {
    final goalId = (await tester.runAsync(
      () => GoalsRepository(db.goalsDao).addGoal(
        Goal(
          type: GoalType.emergency,
          name: 'Fondo de emergencia',
          targetCents: 500000,
          createdAt: DateTime.utc(2026),
        ),
      ),
    ))!;
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await _openCategory(tester, 'Fondo de emergencia');
    await tapVisible(tester, find.byType(FloatingActionButton));

    await _enter(tester, 'Nombre', 'Cuenta remunerada');
    await _enter(tester, 'Entidad', 'Mi banco');
    await _enter(tester, 'Rentabilidad anual (TAE)', 'abc');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));
    expect(find.text('Introduce un número válido'), findsOneWidget);

    await _enter(tester, 'Rentabilidad anual (TAE)', '2,25');
    await tapVisible(tester, find.text('Ninguno'));
    await tapVisible(tester, find.text('Fondo de emergencia').last);
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));

    expect(findMoney('Mi banco · 2,25 % TAE'), findsOneWidget);
    await tapVisible(tester, find.text('Cuenta remunerada'));
    expect(find.widgetWithText(Chip, 'Fondo de emergencia'), findsNWidgets(2));
    final asset = (await tester.runAsync(repo.getAssets))!.single;
    expect(asset.metadata['apy'], closeTo(0.0225, 1e-12));
    expect(asset.goalId, goalId);
  });

  testWidgets('edits and deletes an existing asset', (tester) async {
    await tester.runAsync(
      () => repo.addAsset(
        testAsset(
          AssetCategory.equity,
          name: 'Fondo indexado',
          metadata: const {'ticker': 'IE00B4L5Y983', 'subtype': 'index_fund'},
        ),
      ),
    );
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await _openCategory(tester, 'Renta variable');
    expect(find.text('IE00B4L5Y983 · Fondo indexado'), findsOneWidget);

    await tapVisible(tester, find.text('Fondo indexado').first);
    await tapVisible(tester, find.byTooltip('Editar activo'));
    expect(find.text('Editar activo'), findsOneWidget);
    await _enter(tester, 'Nombre', 'Fondo global');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Guardar'));
    // Back on the detail screen, with the new name in the app bar.
    expect(find.widgetWithText(AppBar, 'Fondo global'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Editar activo'));
    await tapVisible(tester, find.byTooltip('Eliminar'));
    expect(find.text('¿Eliminar este activo?'), findsOneWidget);
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Eliminar'));

    expect(find.text('Aún no tienes nada en esta categoría'), findsOneWidget);
    expect(await tester.runAsync(repo.getAssets), isEmpty);
  });
}
