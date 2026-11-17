import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/utils/dates.dart';

void main() {
  group('monthsBetween', () {
    test('counts whole months', () {
      expect(monthsBetween(DateTime(2026, 1, 15), DateTime(2026, 3, 15)), 2);
      expect(monthsBetween(DateTime(2026, 1, 15), DateTime(2026, 3, 14)), 1);
      expect(monthsBetween(DateTime(2026, 11, 1), DateTime(2028, 11, 1)), 24);
    });

    test('is 0 for the same or a past date', () {
      expect(monthsBetween(DateTime(2026, 5, 1), DateTime(2026, 5, 20)), 0);
      expect(monthsBetween(DateTime(2026, 5, 1), DateTime(2025, 1, 1)), 0);
    });
  });

  group('addMonths', () {
    test('moves across years', () {
      expect(addMonths(DateTime(2026, 11, 17), 3), DateTime(2027, 2, 17));
      expect(addMonths(DateTime(2026, 3, 1), -4), DateTime(2025, 11, 1));
    });

    test('clamps the day to the month length', () {
      expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
      expect(addMonths(DateTime(2028, 1, 31), 1), DateTime(2028, 2, 29));
    });
  });
}
