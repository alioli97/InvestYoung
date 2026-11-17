import 'package:decimal/decimal.dart';

import 'investment_enums.dart';

class AssetTransaction {
  const AssetTransaction({
    this.id,
    required this.assetId,
    required this.type,
    required this.date,
    required this.amountCents,
    this.quantity,
    this.feeCents,
    this.note,
  });

  /// `null` until persisted.
  final int? id;
  final int assetId;
  final TransactionType type;

  /// UTC.
  final DateTime date;
  final int amountCents;

  /// Units bought or sold (`buy` / `sell` only).
  final Decimal? quantity;
  final int? feeCents;
  final String? note;
}
