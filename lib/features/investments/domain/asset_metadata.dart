import '../../../core/domain/db_enum.dart';
import 'investment_enums.dart';

/// Kind of equity asset (docs/SPEC.md §6).
enum EquitySubtype implements DbEnum {
  indexFund('index_fund'),
  etf('etf'),
  stock('stock'),
  other('other');

  const EquitySubtype(this.dbValue);

  @override
  final String dbValue;
}

/// Keys and typed accessors for `Asset.metadata` (stored as JSON).
///
/// Percentages are stored as ratios (`0.025` = 2,5 %) and dates as
/// `yyyy-MM-dd` strings.
abstract final class AssetMetadata {
  // Emergency fund
  static const institution = 'institution';
  static const apy = 'apy';

  // Fixed income
  static const issuer = 'issuer';
  static const yieldRate = 'yield';
  static const maturityDate = 'maturityDate';

  // Equities
  static const ticker = 'ticker';
  static const subtype = 'subtype';

  // Crypto
  static const symbol = 'symbol';
  static const exchange = 'exchange';

  /// Keys used by each category, in display order.
  static List<String> keysFor(AssetCategory category) => switch (category) {
    AssetCategory.emergency => const [institution, apy],
    AssetCategory.fixedIncome => const [issuer, yieldRate, maturityDate],
    AssetCategory.equity => const [ticker, subtype],
    AssetCategory.crypto => const [symbol, exchange],
  };

  static String? text(Map<String, Object?> metadata, String key) {
    final value = metadata[key];
    return value is String && value.trim().isNotEmpty ? value : null;
  }

  static double? ratio(Map<String, Object?> metadata, String key) {
    final value = metadata[key];
    return value is num ? value.toDouble() : null;
  }

  /// Date-only value (e.g. a maturity date) as local midnight.
  static DateTime? date(Map<String, Object?> metadata, String key) {
    final value = metadata[key];
    if (value is! String) return null;
    final parsed = DateTime.tryParse(value);
    // Calendar date without time: local midnight, so it never shifts a day.
    return parsed == null
        ? null
        : DateTime(parsed.year, parsed.month, parsed.day);
  }

  static String encodeDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static EquitySubtype? equitySubtype(Map<String, Object?> metadata) {
    final value = text(metadata, subtype);
    if (value == null) return null;
    for (final s in EquitySubtype.values) {
      if (s.dbValue == value) return s;
    }
    return null;
  }

  /// Removes empty values and keys that do not belong to [category].
  static Map<String, Object?> clean(
    AssetCategory category,
    Map<String, Object?> metadata,
  ) {
    final allowed = keysFor(category).toSet();
    return {
      for (final entry in metadata.entries)
        if (allowed.contains(entry.key) &&
            entry.value != null &&
            !(entry.value is String && (entry.value as String).trim().isEmpty))
          entry.key: entry.value is String
              ? (entry.value as String).trim()
              : entry.value,
    };
  }
}
