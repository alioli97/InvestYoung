import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/domain/asset_summary.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../../helpers/fixtures.dart';

void main() {
  test('pairs each asset with its own transactions', () {
    final summaries = AssetSummary.build(
      [
        testAsset(AssetCategory.emergency, id: 1),
        testAsset(AssetCategory.equity, id: 2),
        testAsset(AssetCategory.equity, id: 3),
      ],
      [
        testTx(1, TransactionType.deposit, 1000),
        testTx(2, TransactionType.buy, 500, quantity: '1'),
        testTx(1, TransactionType.deposit, 250, day: 2),
      ],
    );

    expect(summaries.map((s) => s.metrics.currentValueCents), [1250, 500, 0]);
  });

  test('totals every category, including empty ones', () {
    final totals = AssetSummary.totalsByCategory(
      AssetSummary.build(
        [
          testAsset(AssetCategory.equity, id: 2),
          testAsset(AssetCategory.equity, id: 3),
        ],
        [
          testTx(2, TransactionType.buy, 500, quantity: '1'),
          testTx(3, TransactionType.buy, 1500, quantity: '1'),
          testTx(3, TransactionType.valuation, 2000, day: 2),
        ],
      ),
    );

    expect(totals.keys, AssetCategory.values);
    expect(totals[AssetCategory.equity]!.currentValueCents, 2500);
    expect(totals[AssetCategory.equity]!.returnCents, 500);
    expect(totals[AssetCategory.crypto]!.currentValueCents, 0);
  });
}
