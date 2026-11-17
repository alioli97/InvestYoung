import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_logic.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';

void main() {
  group('riskScore', () {
    test('sums the answer points', () {
      expect(riskScore([1, 1, 1, 1]), 4);
      expect(riskScore([3, 2, 1, 3]), 9);
      expect(riskScore([3, 3, 3, 3]), 12);
    });

    test('rejects the wrong number of answers or invalid points', () {
      expect(() => riskScore([1, 2, 3]), throwsArgumentError);
      expect(() => riskScore([1, 2, 3, 4]), throwsArgumentError);
      expect(() => riskScore([0, 2, 3, 1]), throwsArgumentError);
    });
  });

  group('riskProfileFromScore', () {
    test('maps the score ranges, including boundaries', () {
      expect(riskProfileFromScore(4), RiskProfile.conservative);
      expect(riskProfileFromScore(6), RiskProfile.conservative);
      expect(riskProfileFromScore(7), RiskProfile.moderate);
      expect(riskProfileFromScore(9), RiskProfile.moderate);
      expect(riskProfileFromScore(10), RiskProfile.aggressive);
      expect(riskProfileFromScore(12), RiskProfile.aggressive);
    });

    test('rejects scores outside 4–12', () {
      expect(() => riskProfileFromScore(3), throwsArgumentError);
      expect(() => riskProfileFromScore(13), throwsArgumentError);
    });
  });

  group('emergencyMonthsRange', () {
    EmergencyMonthsRange range({
      RiskProfile risk = RiskProfile.moderate,
      Employment employment = Employment.permanent,
      bool dependents = false,
    }) => emergencyMonthsRange(
      riskProfile: risk,
      employment: employment,
      hasDependents: dependents,
    );

    test('is 3–6 months for a stable, non-conservative profile', () {
      expect(range(), EmergencyMonthsRange.standard);
      expect(
        range(risk: RiskProfile.aggressive),
        EmergencyMonthsRange.standard,
      );
      expect(
        range(employment: Employment.student),
        EmergencyMonthsRange.standard,
      );
    });

    test('is 6–12 months for a conservative profile', () {
      expect(
        range(risk: RiskProfile.conservative),
        EmergencyMonthsRange.extended,
      );
    });

    test('is 6–12 months for unstable employment', () {
      for (final employment in [
        Employment.temporary,
        Employment.selfEmployed,
        Employment.unemployed,
      ]) {
        expect(
          range(employment: employment, risk: RiskProfile.aggressive),
          EmergencyMonthsRange.extended,
          reason: employment.name,
        );
      }
    });

    test('is 6–12 months with dependents', () {
      expect(range(dependents: true), EmergencyMonthsRange.extended);
    });
  });

  group('EmergencyMonthsRange', () {
    test('default is the rounded midpoint', () {
      expect(EmergencyMonthsRange.standard.defaultMonths, 5);
      expect(EmergencyMonthsRange.extended.defaultMonths, 9);
    });

    test('clamps values into the range', () {
      expect(EmergencyMonthsRange.standard.clamp(1), 3);
      expect(EmergencyMonthsRange.standard.clamp(4), 4);
      expect(EmergencyMonthsRange.standard.clamp(9), 6);
    });
  });

  group('recommendedModules', () {
    test('beginners start with the fundamentals', () {
      expect(
        recommendedModules(KnowledgeLevel.none).first,
        LearnModule.fundamentals,
      );
    });

    test('every level gets 3 distinct modules', () {
      for (final level in KnowledgeLevel.values) {
        expect(recommendedModules(level).toSet(), hasLength(3));
      }
    });
  });
}
