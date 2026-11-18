import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/l10n/l10n.dart';
import 'package:invest_young/core/theme/app_theme.dart';
import 'package:invest_young/features/investments/domain/asset_metrics.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/investments/presentation/widgets/asset_metrics_card.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/pump_app.dart';

Future<void> _pumpCard(
  WidgetTester tester,
  AssetCategory category,
  AssetMetrics metrics,
) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.light,
    locale: const Locale('es'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ],
    home: Scaffold(
      body: AssetMetricsCard(category: category, metrics: metrics),
    ),
  ),
);

void main() {
  testWidgets('shows contributed, value, income, return, units and price', (
    tester,
  ) async {
    final metrics = AssetMetrics.fromTransactions([
      testTx(1, TransactionType.buy, 100000, quantity: '10', feeCents: 200),
      testTx(1, TransactionType.income, 1500, day: 2),
      testTx(1, TransactionType.valuation, 110000, day: 3),
    ]);
    await _pumpCard(tester, AssetCategory.equity, metrics);

    expect(find.text('Capital aportado'), findsOneWidget);
    expect(findMoney('1.002,00 €'), findsOneWidget);
    expect(findMoney('1.100,00 €'), findsOneWidget);
    expect(find.text('Dividendos, cupones e intereses'), findsOneWidget);
    expect(findMoney('15,00 €'), findsOneWidget);
    // 1.100 + 15 − 1.002 = +113 € (+11,3 %)
    expect(findMoney('+113,00 € (+11,3 %)'), findsOneWidget);
    expect(find.text('Unidades'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(findMoney('100,20 €'), findsOneWidget);
  });

  testWidgets('hides income and holdings when they do not apply', (
    tester,
  ) async {
    final metrics = AssetMetrics.fromTransactions([
      testTx(1, TransactionType.deposit, 50000),
    ]);
    await _pumpCard(tester, AssetCategory.emergency, metrics);

    expect(find.text('Dividendos, cupones e intereses'), findsNothing);
    expect(find.text('Unidades'), findsNothing);
    expect(find.text('Precio medio de compra'), findsNothing);
    expect(findMoney('500,00 €'), findsNWidgets(2));
  });

  testWidgets('shows a loss in the negative color', (tester) async {
    final metrics = AssetMetrics.fromTransactions([
      testTx(1, TransactionType.buy, 10000, quantity: '1'),
      testTx(1, TransactionType.valuation, 8000, day: 2),
    ]);
    await _pumpCard(tester, AssetCategory.crypto, metrics);

    final text = tester.widget<Text>(findMoney('-20,00 € (-20,0 %)'));
    expect(text.style?.color, const Color(0xFFBA1A1A));
  });
}
