import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

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
  late InvestmentsRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = InvestmentsRepository(db.investmentsDao);
  });

  Future<void> openAsset(
    WidgetTester tester,
    AssetCategory category,
    String categoryName,
  ) async {
    await tester.runAsync(
      () => repo.addAsset(
        testAsset(category, name: 'Mi activo', metadata: const {}),
      ),
    );
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Inversiones').last);
    await tapVisible(tester, find.text(categoryName));
    await tapVisible(tester, find.text('Mi activo'));
  }

  testWidgets('adds buys and a sell, validating units', (tester) async {
    await openAsset(tester, AssetCategory.crypto, 'Criptomonedas');
    expect(
      find.text(
        'Aún no hay movimientos. Añade tu primera aportación o compra.',
      ),
      findsOneWidget,
    );

    // Buy 0,5 units for 1.000 € with a 2 € fee.
    await tapVisible(tester, find.byType(FloatingActionButton));
    expect(find.widgetWithText(ChoiceChip, 'Aportación'), findsNothing);
    await _enter(tester, 'Importe invertido', '1000');
    await _save(tester);
    expect(find.text('Campo obligatorio'), findsOneWidget);
    await _enter(tester, 'Unidades o participaciones', '0,5');
    await _enter(tester, 'Comisión', '2');
    await _save(tester);

    expect(find.text('Compra'), findsOneWidget);
    expect(findMoney('0,5 uds.', contains: true), findsOneWidget);
    expect(findMoney('1.002,00 €'), findsWidgets);

    // Selling more than held is rejected.
    await tapVisible(tester, find.byType(FloatingActionButton));
    await tapVisible(tester, find.widgetWithText(ChoiceChip, 'Venta'));
    await _enter(tester, 'Importe recibido', '700');
    await _enter(tester, 'Unidades o participaciones', '0,6');
    await _save(tester);
    expect(find.text('Solo tienes 0,5 unidades'), findsOneWidget);

    await _enter(tester, 'Unidades o participaciones', '0,2');
    await _save(tester);
    expect(find.text('Venta'), findsOneWidget);

    final txs = (await tester.runAsync(repo.getTransactions))!;
    expect(txs, hasLength(2));
    final buy = txs.firstWhere((t) => t.type == TransactionType.buy);
    expect(buy.quantity, Decimal.parse('0.5'));
    expect(buy.feeCents, 200);
    expect(buy.date.isUtc, isTrue);
  });

  testWidgets('valuation sets the current value', (tester) async {
    await openAsset(tester, AssetCategory.emergency, 'Fondo de emergencia');

    await tapVisible(tester, find.byType(FloatingActionButton));
    expect(find.widgetWithText(ChoiceChip, 'Compra'), findsNothing);
    expect(find.text('Unidades o participaciones'), findsNothing);
    await _enter(tester, 'Importe aportado', '3000');
    await _save(tester);

    await tapVisible(tester, find.byType(FloatingActionButton));
    await tapVisible(
      tester,
      find.widgetWithText(ChoiceChip, 'Actualizar valor'),
    );
    await _enter(tester, 'Valor total actual', '3050');
    await _save(tester);

    expect(findMoney('3.050,00 €'), findsWidgets);
    expect(findMoney('+50,00 €', contains: true), findsOneWidget);
  });

  testWidgets('edits and deletes a transaction', (tester) async {
    await openAsset(tester, AssetCategory.emergency, 'Fondo de emergencia');
    await tapVisible(tester, find.byType(FloatingActionButton));
    await _enter(tester, 'Importe aportado', '100');
    await _save(tester);

    await tapVisible(tester, find.text('Aportación'));
    expect(find.text('Editar movimiento'), findsOneWidget);
    await _enter(tester, 'Importe aportado', '150');
    await _save(tester);
    expect(findMoney('+ 150,00 €'), findsOneWidget);

    await tapVisible(tester, find.text('Aportación'));
    await tapVisible(tester, find.byTooltip('Eliminar'));
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Eliminar'));
    expect(
      find.text(
        'Aún no hay movimientos. Añade tu primera aportación o compra.',
      ),
      findsOneWidget,
    );
    expect(await tester.runAsync(repo.getTransactions), isEmpty);
  });

  testWidgets('rejects a zero amount', (tester) async {
    await openAsset(tester, AssetCategory.emergency, 'Fondo de emergencia');
    await tapVisible(tester, find.byType(FloatingActionButton));
    await _enter(tester, 'Importe aportado', '0');
    await _save(tester);
    expect(find.text('El importe debe ser mayor que 0'), findsOneWidget);
  });
}
