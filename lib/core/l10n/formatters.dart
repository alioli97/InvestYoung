import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale-aware formatting helpers.
///
/// Money is always handled as integer cents and only converted to text here.
/// Dates are stored in UTC and displayed in the device's local time.
class Formatters {
  const Formatters._();

  /// Maps an app [Locale] to the full intl locale name used for formatting.
  static String intlLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ca':
        return 'ca_ES';
      case 'es':
      default:
        return 'es_ES';
    }
  }

  /// Formats [cents] as euros, e.g. `123456` → `1234,56 €` / `1.234,56 €`.
  static String currency(int cents, Locale locale, {int decimalDigits = 2}) {
    final format = NumberFormat.currency(
      locale: intlLocale(locale),
      symbol: '€',
      decimalDigits: decimalDigits,
    );
    return format.format(cents / 100);
  }

  /// Short euro amount for chart axes, e.g. `250000000` → `2,5 M €`.
  static String compactCurrency(int cents, Locale locale) {
    return NumberFormat.compactCurrency(
      locale: intlLocale(locale),
      symbol: '€',
      decimalDigits: 0,
    ).format(cents / 100);
  }

  /// Formats a ratio as a percentage, e.g. `0.05` → `5,0 %`.
  static String percent(double ratio, Locale locale, {int decimalDigits = 1}) {
    final format = NumberFormat.decimalPercentPattern(
      locale: intlLocale(locale),
      decimalDigits: decimalDigits,
    );
    return format.format(ratio);
  }

  /// Formats a price per unit given in (possibly fractional) cents. Prices
  /// under 1 € keep up to 6 decimals so tiny crypto prices stay readable.
  static String unitPrice(Decimal cents, Locale locale) {
    final euros = cents.toDouble() / 100;
    final format = NumberFormat.currency(
      locale: intlLocale(locale),
      symbol: '€',
      decimalDigits: euros.abs() >= 1 || euros == 0 ? 2 : 6,
    );
    return format.format(euros);
  }

  /// Formats a [Decimal] quantity keeping all its decimals, with locale
  /// grouping and decimal comma, e.g. `1234.5678` → `1.234,5678`.
  static String quantity(Decimal value, Locale locale) {
    final negative = value < Decimal.zero;
    final parts = value.abs().toString().split('.');
    final integer = NumberFormat.decimalPattern(
      intlLocale(locale),
    ).format(BigInt.parse(parts[0]).toInt());
    final fraction = parts.length > 1 ? ',${parts[1]}' : '';
    return '${negative ? '-' : ''}$integer$fraction';
  }

  /// Formats a UTC [date] in local time with a medium pattern, e.g. `17 nov 2026`.
  static String date(DateTime date, Locale locale) {
    return DateFormat.yMMMd(intlLocale(locale)).format(date.toLocal());
  }

  /// Formats a UTC [date] in local time as a short numeric date, e.g. `17/11/2026`.
  static String shortDate(DateTime date, Locale locale) {
    return DateFormat.yMd(intlLocale(locale)).format(date.toLocal());
  }
}

/// Convenience accessors that use the current [Localizations] locale.
extension FormattingContext on BuildContext {
  Locale get _locale => Localizations.localeOf(this);

  String formatCurrency(int cents, {int decimalDigits = 2}) =>
      Formatters.currency(cents, _locale, decimalDigits: decimalDigits);

  String formatCompactCurrency(int cents) =>
      Formatters.compactCurrency(cents, _locale);

  String formatPercent(double ratio, {int decimalDigits = 1}) =>
      Formatters.percent(ratio, _locale, decimalDigits: decimalDigits);

  String formatUnitPrice(Decimal cents) => Formatters.unitPrice(cents, _locale);

  String formatQuantity(Decimal value) => Formatters.quantity(value, _locale);

  String formatDate(DateTime date) => Formatters.date(date, _locale);

  String formatShortDate(DateTime date) => Formatters.shortDate(date, _locale);
}
