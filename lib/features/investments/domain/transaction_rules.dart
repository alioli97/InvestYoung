import 'package:decimal/decimal.dart';

import 'asset_metrics.dart';
import 'asset_transaction.dart';
import 'investment_enums.dart';

/// Which transactions and fields make sense for each category.
abstract final class TransactionRules {
  /// Transaction types offered for [category], most common first.
  static List<TransactionType> typesFor(AssetCategory category) =>
      switch (category) {
        AssetCategory.emergency => const [
          TransactionType.deposit,
          TransactionType.withdrawal,
          TransactionType.income,
          TransactionType.valuation,
        ],
        AssetCategory.fixedIncome => const [
          TransactionType.buy,
          TransactionType.sell,
          TransactionType.deposit,
          TransactionType.withdrawal,
          TransactionType.income,
          TransactionType.valuation,
        ],
        AssetCategory.equity || AssetCategory.crypto => const [
          TransactionType.buy,
          TransactionType.sell,
          TransactionType.income,
          TransactionType.valuation,
        ],
      };

  static bool isTrade(TransactionType type) =>
      type == TransactionType.buy || type == TransactionType.sell;

  /// Quantity (units) can be entered for buys and sells, except in the
  /// emergency fund.
  static bool allowsQuantity(AssetCategory category, TransactionType type) =>
      isTrade(type) && category != AssetCategory.emergency;

  /// Units are mandatory for Equities and Crypto trades (holdings, avg price).
  static bool requiresQuantity(AssetCategory category, TransactionType type) =>
      isTrade(type) &&
      (category == AssetCategory.equity || category == AssetCategory.crypto);

  static bool allowsFee(TransactionType type) => isTrade(type);

  /// Units available to sell, ignoring the transaction being edited.
  static Decimal availableToSell(
    List<AssetTransaction> transactions, {
    int? excludingId,
  }) => AssetMetrics.fromTransactions(
    excludingId == null
        ? transactions
        : transactions.where((t) => t.id != excludingId),
  ).holdings;
}

/// Parses a positive quantity typed by the user (`0,0015`, `12.5`).
Decimal? parseQuantity(String input) {
  final text = input.trim().replaceAll(',', '.');
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(text)) return null;
  final value = Decimal.parse(text);
  return value > Decimal.zero ? value : null;
}
