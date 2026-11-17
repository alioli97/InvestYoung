import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/utils/finance.dart';

void main() {
  group('emergencyFundTarget', () {
    test('multiplies monthly expenses by months', () {
      expect(emergencyFundTarget(120000, 6), 720000);
      expect(emergencyFundTarget(95050, 3), 285150);
    });

    test('handles zero expenses and zero months', () {
      expect(emergencyFundTarget(0, 6), 0);
      expect(emergencyFundTarget(120000, 0), 0);
    });

    test('rejects negative months', () {
      expect(() => emergencyFundTarget(1000, -1), throwsArgumentError);
    });
  });

  group('monthlyRate', () {
    test('is 0 for a 0% annual rate', () {
      expect(monthlyRate(0), 0);
    });

    test('compounds back to the annual rate', () {
      final r = monthlyRate(0.05);
      expect(math.pow(1 + r, 12), closeTo(1.05, 1e-12));
      expect(r, closeTo(0.0040741237836, 1e-12));
    });

    test('supports negative rates above -100%', () {
      expect(monthlyRate(-0.1), lessThan(0));
      expect(() => monthlyRate(-1), throwsArgumentError);
    });
  });

  group('requiredMonthlyContribution', () {
    test('with r = 0 splits the remaining amount evenly', () {
      expect(
        requiredMonthlyContribution(
          targetCents: 1200000,
          currentCents: 0,
          annualRate: 0,
          months: 12,
        ),
        100000,
      );
      expect(
        requiredMonthlyContribution(
          targetCents: 1000000,
          currentCents: 400000,
          annualRate: 0,
          months: 24,
        ),
        25000,
      );
    });

    test('rounds up to the next cent', () {
      expect(
        requiredMonthlyContribution(
          targetCents: 1000,
          currentCents: 0,
          annualRate: 0,
          months: 3,
        ),
        334,
      );
    });

    test('with r > 0 uses the annuity formula', () {
      // 60,000 € in 5 years at 5%, starting from 10,000 €.
      final r = monthlyRate(0.05);
      final fvCurrent = 1000000 * math.pow(1 + r, 60);
      final expected = (6000000 - fvCurrent) * r / (math.pow(1 + r, 60) - 1);

      final result = requiredMonthlyContribution(
        targetCents: 6000000,
        currentCents: 1000000,
        annualRate: 0.05,
        months: 60,
      );
      expect(result, expected.ceil());
      expect(result, lessThan((6000000 - 1000000) ~/ 60));
    });

    test('the result actually reaches the target when projected', () {
      final monthly = requiredMonthlyContribution(
        targetCents: 3000000,
        currentCents: 250000,
        annualRate: 0.07,
        months: 120,
      );
      final last = projectGrowth(
        currentCents: 250000,
        monthlyCents: monthly,
        annualRate: 0.07,
        months: 120,
      ).last;
      expect(last.valueCents, greaterThanOrEqualTo(3000000));
      expect(last.valueCents - 3000000, lessThan(120 * 2));
    });

    test('is 0 when the goal is already reached', () {
      expect(
        requiredMonthlyContribution(
          targetCents: 500000,
          currentCents: 600000,
          annualRate: 0.03,
          months: 12,
        ),
        0,
      );
      expect(
        requiredMonthlyContribution(
          targetCents: 500000,
          currentCents: 500000,
          annualRate: 0,
          months: 12,
        ),
        0,
      );
    });

    test('is 0 when growth alone reaches the target', () {
      expect(
        requiredMonthlyContribution(
          targetCents: 110000,
          currentCents: 100000,
          annualRate: 0.10,
          months: 12,
        ),
        0,
      );
    });

    test('with n = 0 returns the remaining amount', () {
      expect(
        requiredMonthlyContribution(
          targetCents: 500000,
          currentCents: 200000,
          annualRate: 0.05,
          months: 0,
        ),
        300000,
      );
      expect(
        requiredMonthlyContribution(
          targetCents: 500000,
          currentCents: 900000,
          annualRate: 0.05,
          months: 0,
        ),
        0,
      );
    });

    test('rejects negative months', () {
      expect(
        () => requiredMonthlyContribution(
          targetCents: 1,
          currentCents: 0,
          annualRate: 0,
          months: -1,
        ),
        throwsArgumentError,
      );
    });
  });

  group('housingTarget', () {
    test('adds down payment and fees over the home price', () {
      expect(
        housingTarget(
          homePriceCents: 20000000,
          downPaymentRatio: 0.20,
          feesRatio: 0.10,
        ),
        6000000,
      );
      expect(
        housingTarget(
          homePriceCents: 15000000,
          downPaymentRatio: 0.15,
          feesRatio: 0.12,
        ),
        4050000,
      );
    });

    test('is 0 for a 0 € home or 0 %', () {
      expect(
        housingTarget(homePriceCents: 0, downPaymentRatio: 0.2, feesRatio: 0.1),
        0,
      );
      expect(
        housingTarget(homePriceCents: 100, downPaymentRatio: 0, feesRatio: 0),
        0,
      );
    });
  });

  group('retirementTarget', () {
    test('applies the 4% rule (× 12 × 25)', () {
      expect(retirementTarget(150000), 45000000);
      expect(retirementTarget(0), 0);
    });
  });

  group('projectGrowth', () {
    test('returns months + 1 points starting today', () {
      final points = projectGrowth(
        currentCents: 100000,
        monthlyCents: 10000,
        annualRate: 0.05,
        months: 24,
      );
      expect(points, hasLength(25));
      expect(
        points.first,
        const GrowthPoint(
          month: 0,
          valueCents: 100000,
          contributedCents: 100000,
        ),
      );
      expect(points.last.month, 24);
    });

    test('with r = 0 value equals contributed capital', () {
      final points = projectGrowth(
        currentCents: 50000,
        monthlyCents: 2500,
        annualRate: 0,
        months: 4,
      );
      expect(points.map((p) => p.valueCents), [
        50000,
        52500,
        55000,
        57500,
        60000,
      ]);
      expect(points.map((p) => p.contributedCents), [
        50000,
        52500,
        55000,
        57500,
        60000,
      ]);
    });

    test('compounds the initial capital without contributions', () {
      final points = projectGrowth(
        currentCents: 1000000,
        monthlyCents: 0,
        annualRate: 0.05,
        months: 12,
      );
      expect(points.last.valueCents, 1050000);
      expect(points.last.contributedCents, 1000000);
    });

    test('value grows faster than contributions with a positive rate', () {
      final points = projectGrowth(
        currentCents: 0,
        monthlyCents: 20000,
        annualRate: 0.06,
        months: 360,
      );
      final last = points.last;
      expect(last.contributedCents, 7200000);
      expect(last.valueCents, greaterThan(last.contributedCents * 2));
    });

    test('with n = 0 returns only today', () {
      final points = projectGrowth(
        currentCents: 1234,
        monthlyCents: 100,
        annualRate: 0.05,
        months: 0,
      );
      expect(points, [
        const GrowthPoint(month: 0, valueCents: 1234, contributedCents: 1234),
      ]);
    });
  });
}
