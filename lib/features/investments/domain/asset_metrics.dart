import 'package:decimal/decimal.dart';

import 'asset_transaction.dart';
import 'investment_enums.dart';

/// Per-asset metrics from docs/SPEC.md §6. All money values are cents.
class AssetMetrics {
  const AssetMetrics({
    required this.netContributedCents,
    required this.currentValueCents,
    required this.incomeCents,
    required this.holdings,
    required this.averagePurchasePriceCents,
  });

  /// Calculates the metrics of one asset from its [transactions] (any order).
  ///
  /// - Net contributed = deposits + buys − withdrawals − sells. Fees count as
  ///   money paid in: a buy adds `amount + fee`, a sell subtracts `amount − fee`.
  /// - Current value = latest `valuation`, plus the deposits/buys minus the
  ///   withdrawals/sells dated after it (so a purchase made after the last
  ///   manual update is not lost). Without valuations: net contributed.
  /// - Holdings = Σ buy quantities − Σ sell quantities.
  /// - Average purchase price = Σ buy cost (amount + fee) / Σ buy quantity.
  factory AssetMetrics.fromTransactions(
    Iterable<AssetTransaction> transactions,
  ) {
    final sorted = transactions.toList()..sort(_chronological);

    var netContributed = 0;
    var income = 0;
    int? valuation;
    var flowsSinceValuation = 0;
    var holdings = Decimal.zero;
    var boughtQuantity = Decimal.zero;
    var boughtCost = 0;

    for (final tx in sorted) {
      final fee = tx.feeCents ?? 0;
      final quantity = tx.quantity ?? Decimal.zero;
      switch (tx.type) {
        case TransactionType.deposit:
          netContributed += tx.amountCents;
          flowsSinceValuation += tx.amountCents;
        case TransactionType.withdrawal:
          netContributed -= tx.amountCents;
          flowsSinceValuation -= tx.amountCents;
        case TransactionType.buy:
          netContributed += tx.amountCents + fee;
          flowsSinceValuation += tx.amountCents;
          holdings += quantity;
          boughtQuantity += quantity;
          boughtCost += tx.amountCents + fee;
        case TransactionType.sell:
          netContributed -= tx.amountCents - fee;
          flowsSinceValuation -= tx.amountCents;
          holdings -= quantity;
        case TransactionType.income:
          income += tx.amountCents;
        case TransactionType.valuation:
          valuation = tx.amountCents;
          flowsSinceValuation = 0;
      }
    }

    return AssetMetrics(
      netContributedCents: netContributed,
      currentValueCents: valuation == null
          ? netContributed
          : valuation + flowsSinceValuation,
      incomeCents: income,
      holdings: holdings,
      averagePurchasePriceCents: boughtQuantity == Decimal.zero
          ? null
          : (Decimal.fromInt(boughtCost) / boughtQuantity).toDecimal(
              scaleOnInfinitePrecision: 8,
              toBigInt: (value) => value.round(),
            ),
    );
  }

  static final empty = AssetMetrics(
    netContributedCents: 0,
    currentValueCents: 0,
    incomeCents: 0,
    holdings: Decimal.zero,
    averagePurchasePriceCents: null,
  );

  final int netContributedCents;
  final int currentValueCents;

  /// Dividends, coupons and interest received.
  final int incomeCents;

  /// Units held (meaningful for Equities and Crypto).
  final Decimal holdings;

  /// Cost per unit in cents (rounded to 8 decimals), or `null` if nothing was
  /// bought with a quantity.
  final Decimal? averagePurchasePriceCents;

  /// Return = current value + income − net contributed.
  int get returnCents => currentValueCents + incomeCents - netContributedCents;

  /// Return over net contributed capital as a ratio (`0.1` = 10 %), or `null`
  /// when nothing net has been contributed.
  double? get returnRatio =>
      netContributedCents > 0 ? returnCents / netContributedCents : null;

  /// Aggregates several assets (e.g. a category or a goal). Holdings and
  /// average price are not additive across assets and are left empty.
  static AssetMetrics sum(Iterable<AssetMetrics> metrics) {
    var contributed = 0;
    var value = 0;
    var income = 0;
    for (final m in metrics) {
      contributed += m.netContributedCents;
      value += m.currentValueCents;
      income += m.incomeCents;
    }
    return AssetMetrics(
      netContributedCents: contributed,
      currentValueCents: value,
      incomeCents: income,
      holdings: Decimal.zero,
      averagePurchasePriceCents: null,
    );
  }

  static int _chronological(AssetTransaction a, AssetTransaction b) {
    final byDate = a.date.compareTo(b.date);
    if (byDate != 0) return byDate;
    return (a.id ?? 0).compareTo(b.id ?? 0);
  }
}
