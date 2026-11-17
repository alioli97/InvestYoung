import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/l10n/money_input.dart';

void main() {
  group('parseEurosToCents', () {
    test('parses whole euros', () {
      expect(parseEurosToCents('0'), 0);
      expect(parseEurosToCents('600'), 60000);
      expect(parseEurosToCents(' 600 € '), 60000);
    });

    test('parses comma decimals', () {
      expect(parseEurosToCents('600,5'), 60050);
      expect(parseEurosToCents('600,05'), 60005);
      expect(parseEurosToCents('1.234,56'), 123456);
    });

    test('treats a dot with 1–2 decimals as a decimal separator', () {
      expect(parseEurosToCents('12.5'), 1250);
      expect(parseEurosToCents('1234.56'), 123456);
    });

    test('treats other dots as thousands separators', () {
      expect(parseEurosToCents('1.234'), 123400);
      expect(parseEurosToCents('1.234.567'), 123456700);
    });

    test('rejects invalid input', () {
      expect(parseEurosToCents(''), isNull);
      expect(parseEurosToCents('abc'), isNull);
      expect(parseEurosToCents('-5'), isNull);
      expect(parseEurosToCents('1,234'), isNull);
      expect(parseEurosToCents('1,2,3'), isNull);
    });
  });

  group('formatCentsForInput', () {
    test('omits decimals for whole euros', () {
      expect(formatCentsForInput(60000), '600');
      expect(formatCentsForInput(0), '0');
    });

    test('uses comma decimals', () {
      expect(formatCentsForInput(60050), '600,50');
      expect(formatCentsForInput(5), '0,05');
    });

    test('round-trips with parseEurosToCents', () {
      for (final cents in [0, 1, 99, 100, 123456, 9999999]) {
        expect(parseEurosToCents(formatCentsForInput(cents)), cents);
      }
    });
  });
}
