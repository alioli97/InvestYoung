import 'package:decimal/decimal.dart';

import '../../investments/domain/asset.dart';
import '../../investments/domain/asset_transaction.dart';
import '../../investments/domain/investment_enums.dart';

/// Localized texts of the CSV (headers and enum labels).
class TransactionsCsvLabels {
  const TransactionsCsvLabels({
    required this.headers,
    required this.category,
    required this.type,
  });

  /// Date, asset, category, type, amount, quantity, fee, note.
  final List<String> headers;
  final String Function(AssetCategory) category;
  final String Function(TransactionType) type;
}

/// Builds a CSV of all transactions, oldest first, ready for a spreadsheet
/// in Spanish/Catalan locales: `;` separator, decimal comma, no thousands
/// separator, local `yyyy-mm-dd` dates, CRLF line ends and a UTF-8 BOM so
/// accents display correctly in Excel.
String buildTransactionsCsv({
  required List<Asset> assets,
  required List<AssetTransaction> transactions,
  required TransactionsCsvLabels labels,
}) {
  final assetsById = {for (final a in assets) a.id: a};
  final sorted = [...transactions]
    ..sort((a, b) {
      final byDate = a.date.compareTo(b.date);
      return byDate != 0 ? byDate : (a.id ?? 0).compareTo(b.id ?? 0);
    });

  final lines = [
    _row(labels.headers),
    for (final tx in sorted)
      _row([
        _date(tx.date),
        assetsById[tx.assetId]?.name ?? '',
        switch (assetsById[tx.assetId]) {
          null => '',
          final asset => labels.category(asset.category),
        },
        labels.type(tx.type),
        _cents(tx.amountCents),
        tx.quantity == null ? '' : _decimal(tx.quantity!),
        tx.feeCents == null ? '' : _cents(tx.feeCents!),
        tx.note ?? '',
      ]),
  ];
  return '\uFEFF${lines.join('\r\n')}\r\n';
}

String _row(List<String> fields) => fields.map(_escape).join(';');

/// Quotes fields with separators, quotes or line breaks (RFC 4180 style).
String _escape(String field) {
  if (!field.contains(RegExp(r'[;"\r\n]'))) return field;
  return '"${field.replaceAll('"', '""')}"';
}

String _date(DateTime utc) {
  final local = utc.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)}';
}

String _cents(int cents) {
  final sign = cents < 0 ? '-' : '';
  final abs = cents.abs();
  return '$sign${abs ~/ 100},${(abs % 100).toString().padLeft(2, '0')}';
}

String _decimal(Decimal value) => value.toString().replaceAll('.', ',');
