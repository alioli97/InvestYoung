import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:invest_young/core/l10n/formatters.dart';

// intl uses narrow no-break spaces in some patterns; normalize for readability.
String _n(String s) => s.replaceAll(' ', ' ').replaceAll(' ', ' ');

void main() {
  const es = Locale('es');
  const ca = Locale('ca');

  setUpAll(() async {
    await initializeDateFormatting();
  });

  group('intlLocale', () {
    test('maps app locales to Spanish regional locales', () {
      expect(Formatters.intlLocale(es), 'es_ES');
      expect(Formatters.intlLocale(ca), 'ca_ES');
    });

    test('falls back to es_ES for unsupported locales', () {
      expect(Formatters.intlLocale(const Locale('en')), 'es_ES');
    });
  });

  group('currency', () {
    test('formats cents as euros with comma decimals', () {
      expect(_n(Formatters.currency(1050, es)), '10,50 €');
      expect(_n(Formatters.currency(1050, ca)), '10,50 €');
    });

    test('groups thousands with dots for large amounts', () {
      expect(_n(Formatters.currency(1234567, es)), '12.345,67 €');
      expect(_n(Formatters.currency(1234567, ca)), '12.345,67 €');
    });

    test('handles zero and negatives', () {
      expect(_n(Formatters.currency(0, es)), '0,00 €');
      expect(_n(Formatters.currency(-2500, es)), '-25,00 €');
    });

    test('supports custom decimal digits', () {
      expect(
        _n(Formatters.currency(1234567, es, decimalDigits: 0)),
        '12.346 €',
      );
    });
  });

  group('percent', () {
    test('formats ratios as percentages', () {
      expect(_n(Formatters.percent(0.05, es)), '5,0 %');
      expect(_n(Formatters.percent(0.1234, ca, decimalDigits: 2)), '12,34 %');
      expect(_n(Formatters.percent(-0.2, es, decimalDigits: 0)), '-20 %');
    });
  });

  group('quantity', () {
    test('keeps every decimal and uses locale separators', () {
      expect(
        Formatters.quantity(Decimal.parse('0.00012345'), es),
        '0,00012345',
      );
      expect(Formatters.quantity(Decimal.parse('12'), ca), '12');
      expect(
        Formatters.quantity(Decimal.parse('1234567.5'), es),
        '1.234.567,5',
      );
      expect(Formatters.quantity(Decimal.parse('-3.25'), es), '-3,25');
    });
  });

  group('unitPrice', () {
    test('uses 2 decimals from 1 € and up to 6 below', () {
      expect(
        _n(Formatters.unitPrice(Decimal.parse('8500000'), es)),
        '85.000,00 €',
      );
      expect(
        _n(Formatters.unitPrice(Decimal.parse('10686.66666667'), es)),
        '106,87 €',
      );
      expect(
        _n(Formatters.unitPrice(Decimal.parse('0.0123'), ca)),
        '0,000123 €',
      );
      expect(_n(Formatters.unitPrice(Decimal.zero, es)), '0,00 €');
    });
  });

  group('dates', () {
    final utc = DateTime.utc(2026, 3, 15, 12);

    test('short date uses day/month/year order', () {
      expect(Formatters.shortDate(utc, es), '15/3/2026');
      expect(Formatters.shortDate(utc, ca), '15/3/2026');
    });

    test('medium date contains localized month', () {
      expect(Formatters.date(utc, es), contains('mar'));
      expect(Formatters.date(utc, ca), contains('març'));
    });

    test('converts UTC to local time before formatting', () {
      final local = utc.toLocal();
      expect(
        Formatters.shortDate(utc, es),
        '${local.day}/${local.month}/${local.year}',
      );
    });
  });
}
