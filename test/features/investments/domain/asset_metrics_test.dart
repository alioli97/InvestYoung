import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/domain/asset_metrics.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

var _nextId = 1;

AssetTransaction _tx(
  TransactionType type,
  int amountCents, {
  required int day,
  String? quantity,
  int? feeCents,
}) => AssetTransaction(
  id: _nextId++,
  assetId: 1,
  type: type,
  date: DateTime.utc(2026, 1, day),
  amountCents: amountCents,
  quantity: quantity == null ? null : Decimal.parse(quantity),
  feeCents: feeCents,
);

void main() {
  test('empty asset has zero metrics', () {
    final m = AssetMetrics.fromTransactions(const []);
    expect(m.netContributedCents, 0);
    expect(m.currentValueCents, 0);
    expect(m.returnCents, 0);
    expect(m.returnRatio, isNull);
    expect(m.holdings, Decimal.zero);
    expect(m.averagePurchasePriceCents, isNull);
  });

  group('savings-like assets (deposits, withdrawals, income)', () {
    final txs = [
      _tx(TransactionType.deposit, 100000, day: 1),
      _tx(TransactionType.deposit, 50000, day: 2),
      _tx(TransactionType.withdrawal, 20000, day: 3),
      _tx(TransactionType.income, 1500, day: 4),
    ];

    test('net contributed = deposits − withdrawals', () {
      expect(AssetMetrics.fromTransactions(txs).netContributedCents, 130000);
    });

    test('without valuation, value = net contributed', () {
      expect(AssetMetrics.fromTransactions(txs).currentValueCents, 130000);
    });

    test('income counts as return', () {
      final m = AssetMetrics.fromTransactions(txs);
      expect(m.returnCents, 1500);
      expect(m.returnRatio, closeTo(1500 / 130000, 1e-12));
    });
  });

  group('valuations', () {
    test('latest valuation (by date) is the current value', () {
      final m = AssetMetrics.fromTransactions([
        _tx(TransactionType.valuation, 99999, day: 10),
        _tx(TransactionType.deposit, 100000, day: 1),
        _tx(TransactionType.valuation, 110000, day: 5),
      ]);
      expect(m.currentValueCents, 99999);
      expect(m.returnCents, -1);
    });

    test('flows after the latest valuation are added to it', () {
      final m = AssetMetrics.fromTransactions([
        _tx(TransactionType.deposit, 100000, day: 1),
        _tx(TransactionType.valuation, 120000, day: 2),
        _tx(TransactionType.deposit, 30000, day: 3),
        _tx(TransactionType.withdrawal, 10000, day: 4),
      ]);
      expect(m.netContributedCents, 120000);
      expect(m.currentValueCents, 140000);
      expect(m.returnCents, 20000);
      expect(m.returnRatio, closeTo(20000 / 120000, 1e-12));
    });

    test('same-day transactions are ordered by id', () {
      final deposit = AssetTransaction(
        id: 2,
        assetId: 1,
        type: TransactionType.deposit,
        date: DateTime.utc(2026, 2, 1),
        amountCents: 500,
      );
      final valuation = AssetTransaction(
        id: 1,
        assetId: 1,
        type: TransactionType.valuation,
        date: DateTime.utc(2026, 2, 1),
        amountCents: 1000,
      );
      expect(
        AssetMetrics.fromTransactions([deposit, valuation]).currentValueCents,
        1500,
      );
    });
  });

  group('equities and crypto (buy/sell with quantities)', () {
    final txs = [
      _tx(TransactionType.buy, 100000, day: 1, quantity: '10', feeCents: 200),
      _tx(TransactionType.buy, 60000, day: 2, quantity: '5', feeCents: 100),
      _tx(TransactionType.sell, 45000, day: 3, quantity: '3', feeCents: 100),
      _tx(TransactionType.income, 1200, day: 4),
      _tx(TransactionType.valuation, 150000, day: 5),
    ];

    test('net contributed includes fees', () {
      // (100000 + 200) + (60000 + 100) − (45000 − 100)
      expect(AssetMetrics.fromTransactions(txs).netContributedCents, 115400);
    });

    test('holdings = bought − sold quantities', () {
      expect(AssetMetrics.fromTransactions(txs).holdings, Decimal.fromInt(12));
    });

    test('average purchase price includes fees', () {
      // (100200 + 60100) / 15
      expect(
        AssetMetrics.fromTransactions(txs).averagePurchasePriceCents,
        Decimal.parse('10686.66666667'),
      );
    });

    test('return = value + income − net contributed', () {
      final m = AssetMetrics.fromTransactions(txs);
      expect(m.returnCents, 150000 + 1200 - 115400);
    });

    test('keeps crypto precision for tiny quantities', () {
      final m = AssetMetrics.fromTransactions([
        _tx(TransactionType.buy, 5000, day: 1, quantity: '0.00012345'),
        _tx(TransactionType.sell, 1000, day: 2, quantity: '0.00002345'),
      ]);
      expect(m.holdings, Decimal.parse('0.0001'));
      expect(m.netContributedCents, 4000);
    });
  });

  test('return ratio is null when everything was withdrawn', () {
    final m = AssetMetrics.fromTransactions([
      _tx(TransactionType.deposit, 1000, day: 1),
      _tx(TransactionType.withdrawal, 1000, day: 2),
      _tx(TransactionType.income, 50, day: 3),
    ]);
    expect(m.netContributedCents, 0);
    expect(m.returnCents, 50);
    expect(m.returnRatio, isNull);
  });

  test('sum aggregates money metrics of several assets', () {
    final a = AssetMetrics.fromTransactions([
      _tx(TransactionType.deposit, 1000, day: 1),
      _tx(TransactionType.income, 10, day: 2),
    ]);
    final b = AssetMetrics.fromTransactions([
      _tx(TransactionType.buy, 2000, day: 1, quantity: '1'),
      _tx(TransactionType.valuation, 2500, day: 2),
    ]);
    final total = AssetMetrics.sum([a, b]);
    expect(total.netContributedCents, 3000);
    expect(total.currentValueCents, 3500);
    expect(total.incomeCents, 10);
    expect(total.returnCents, 510);
    expect(AssetMetrics.sum(const []).currentValueCents, 0);
  });
}
