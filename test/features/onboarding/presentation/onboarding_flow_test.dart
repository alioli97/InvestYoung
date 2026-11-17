import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';

import 'package:invest_young/features/onboarding/domain/user_profile.dart';

import '../../../helpers/pump_app.dart';

Future<void> _continue(WidgetTester tester) =>
    tapVisible(tester, find.widgetWithText(FilledButton, 'Continuar'));

/// Completes onboarding with fixed answers, ending on the result step.
Future<void> completeUntilResult(WidgetTester tester) async {
  // 0. Language
  await _continue(tester);
  // 1. Legal notice
  await tapVisible(tester, find.text('He leído y acepto el aviso legal'));
  await _continue(tester);
  // 2. Situation
  await tapVisible(tester, find.text('21–25'));
  await tapVisible(tester, find.text('Contrato temporal'));
  await tapVisible(tester, find.widgetWithText(ChoiceChip, 'No').first);
  await tapVisible(tester, find.widgetWithText(ChoiceChip, 'Sí').last);
  await _continue(tester);
  // 3. Expenses
  final housing = find.widgetWithText(
    TextField,
    'Vivienda (alquiler o hipoteca, suministros)',
  );
  await tester.enterText(housing, '600');
  await tester.enterText(
    find.widgetWithText(TextField, 'Alimentación'),
    '200,50',
  );
  await tester.pumpAndSettle();
  expect(find.textContaining('800,50'), findsOneWidget);
  await _continue(tester);
  // 4. Risk: answer 2 points on every question
  for (final answer in [
    'Espero a que se recupere',
    'Entre 2 y 5 años',
    'Asumir algo de riesgo por algo más de rentabilidad',
    'Incómodo/a, pero lo aguantaría',
  ]) {
    await tapVisible(tester, find.text(answer));
  }
  await _continue(tester);
  // 5. Goals
  await tapVisible(tester, find.text('Jubilación'));
  await _continue(tester);
  // 6. Knowledge
  await tapVisible(tester, find.text('Lo básico'));
  await _continue(tester);
}

void main() {
  testWidgets('walks through the 8 steps and saves the result', (tester) async {
    final db = await pumpApp(tester);
    expect(find.text('Paso 1 de 8'), findsOneWidget);

    await completeUntilResult(tester);

    expect(find.text('Paso 8 de 8'), findsOneWidget);
    expect(find.text('Moderado'), findsOneWidget);
    // Temporary job → 6–12 months, default 9 × 800,50 €.
    expect(find.textContaining('entre 6 y 12 meses'), findsOneWidget);
    expect(find.textContaining('7.204,50'), findsOneWidget);
    expect(
      find.text('Prioriza pagar esta deuda antes de invertir'),
      findsOneWidget,
    );

    await tapVisible(tester, find.text('Confirmar y empezar'));
    expect(find.byType(NavigationBar), findsOneWidget);

    final profile = await db.select(db.userProfiles).getSingle();
    expect(profile.employment, Employment.temporary);
    expect(profile.riskProfile, RiskProfile.moderate);
    expect(profile.emergencyMonths, 9);
    expect(profile.hasHighInterestDebt, isTrue);
    expect(profile.locale, 'es');
    expect(profile.onboardingCompletedAt, isNotNull);

    final goals = await db.select(db.goals).get();
    expect(goals.map((g) => g.type), [GoalType.emergency, GoalType.retirement]);
    expect(goals.first.targetCents, 720450);
    expect(await db.select(db.monthlyExpenses).get(), hasLength(6));
  });

  testWidgets('starts on Home with the saved language when onboarded', (
    tester,
  ) async {
    await pumpApp(
      tester,
      startupProfile: UserProfile(
        ageRange: AgeRange.over35,
        employment: Employment.permanent,
        hasDependents: false,
        hasHighInterestDebt: false,
        riskScore: 8,
        riskProfile: RiskProfile.moderate,
        knowledgeLevel: KnowledgeLevel.basic,
        emergencyMonths: 5,
        locale: 'ca',
        onboardingCompletedAt: DateTime.utc(2026),
      ),
    );
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Inici'), findsWidgets);
  });

  testWidgets('continue is disabled until the legal notice is accepted', (
    tester,
  ) async {
    await pumpApp(tester);
    await _continue(tester);

    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continuar'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('back returns to the previous step', (tester) async {
    await pumpApp(tester);
    await _continue(tester);
    expect(find.text('Paso 2 de 8'), findsOneWidget);

    await tapVisible(tester, find.text('Atrás'));
    expect(find.text('Paso 1 de 8'), findsOneWidget);
  });

  testWidgets('choosing Catalan switches the language immediately', (
    tester,
  ) async {
    await pumpApp(tester);
    await tapVisible(tester, find.text('Catalán'));

    expect(find.text('Tria el teu idioma'), findsOneWidget);
    expect(find.text('Pas 1 de 8'), findsOneWidget);
  });
}
