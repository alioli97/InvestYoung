import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/test_database.dart';

void main() {
  testWidgets('shows the 4 categories with zero totals when empty', (
    tester,
  ) async {
    await pumpApp(tester, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Inversiones').last);

    expect(find.text('Valor total'), findsOneWidget);
    for (final name in [
      'Fondo de emergencia',
      'Renta fija',
      'Renta variable',
      'Criptomonedas',
    ]) {
      expect(find.text(name), findsOneWidget);
    }
    expect(findMoney('0,00 €'), findsNWidgets(5));
  });

  testWidgets('shows category totals and returns', (tester) async {
    final db = createTestDatabase();
    final repo = InvestmentsRepository(db.investmentsDao);
    await tester.runAsync(() async {
      final savings = await repo.addAsset(testAsset(AssetCategory.emergency));
      await repo.addTransaction(
        testTx(savings, TransactionType.deposit, 300000),
      );
      final fund = await repo.addAsset(testAsset(AssetCategory.equity));
      await repo.addTransaction(
        testTx(fund, TransactionType.buy, 100000, quantity: '10'),
      );
      await repo.addTransaction(
        testTx(fund, TransactionType.valuation, 110000, day: 2),
      );
    });

    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tapVisible(tester, find.text('Inversiones').last);

    expect(findMoney('4.100,00 €'), findsOneWidget);
    expect(findMoney('3.000,00 €'), findsOneWidget);
    expect(findMoney('1.100,00 €'), findsOneWidget);
    expect(findMoney('+100,00 €', contains: true), findsNWidgets(2));
    expect(findMoney('+10,0', contains: true), findsOneWidget);
    expect(findMoney('Aportado: 4.000,00 €'), findsOneWidget);
  });
}
