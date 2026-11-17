import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/investments/domain/transaction_rules.dart';

void main() {
  test('each category offers its own transaction types', () {
    expect(
      TransactionRules.typesFor(AssetCategory.emergency),
      isNot(contains(TransactionType.buy)),
    );
    expect(
      TransactionRules.typesFor(AssetCategory.crypto),
      isNot(contains(TransactionType.deposit)),
    );
    expect(
      TransactionRules.typesFor(AssetCategory.fixedIncome).toSet(),
      TransactionType.values.toSet(),
    );
    for (final category in AssetCategory.values) {
      expect(
        TransactionRules.typesFor(category),
        contains(TransactionType.valuation),
      );
    }
  });

  test('quantity is required only for equity and crypto trades', () {
    expect(
      TransactionRules.requiresQuantity(
        AssetCategory.equity,
        TransactionType.buy,
      ),
      isTrue,
    );
    expect(
      TransactionRules.requiresQuantity(
        AssetCategory.crypto,
        TransactionType.income,
      ),
      isFalse,
    );
    expect(
      TransactionRules.requiresQuantity(
        AssetCategory.fixedIncome,
        TransactionType.buy,
      ),
      isFalse,
    );
    expect(
      TransactionRules.allowsQuantity(
        AssetCategory.fixedIncome,
        TransactionType.buy,
      ),
      isTrue,
    );
    expect(
      TransactionRules.allowsQuantity(
        AssetCategory.emergency,
        TransactionType.deposit,
      ),
      isFalse,
    );
  });

  test('fees apply to trades only', () {
    expect(TransactionRules.allowsFee(TransactionType.sell), isTrue);
    expect(TransactionRules.allowsFee(TransactionType.deposit), isFalse);
  });

  test('available to sell excludes the transaction being edited', () {
    final withIds = [
      AssetTransaction(
        id: 1,
        assetId: 1,
        type: TransactionType.buy,
        date: DateTime.utc(2026),
        amountCents: 1000,
        quantity: Decimal.fromInt(2),
      ),
      AssetTransaction(
        id: 2,
        assetId: 1,
        type: TransactionType.sell,
        date: DateTime.utc(2026, 2),
        amountCents: 600,
        quantity: Decimal.parse('0.5'),
      ),
    ];
    expect(TransactionRules.availableToSell(withIds), Decimal.parse('1.5'));
    expect(
      TransactionRules.availableToSell(withIds, excludingId: 2),
      Decimal.fromInt(2),
    );
  });

  group('parseQuantity', () {
    test('accepts comma or dot decimals', () {
      expect(parseQuantity('0,0015'), Decimal.parse('0.0015'));
      expect(parseQuantity(' 12.5 '), Decimal.parse('12.5'));
      expect(parseQuantity('3'), Decimal.fromInt(3));
    });

    test('rejects zero, negatives and garbage', () {
      expect(parseQuantity('0'), isNull);
      expect(parseQuantity('-1'), isNull);
      expect(parseQuantity('1.2.3'), isNull);
      expect(parseQuantity(''), isNull);
    });
  });
}
