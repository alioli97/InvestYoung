import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/core/domain/app_theme_mode.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/onboarding/data/onboarding_repository.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/onboarding_answers.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;

  setUp(() {
    db = createTestDatabase();
    profiles = ProfileRepository(db.profileDao);
  });

  Future<void> openProfile(WidgetTester tester, {UserProfile? profile}) async {
    final saved = profile ?? onboardedProfile();
    await tester.runAsync(() => profiles.saveProfile(saved));
    await pumpApp(tester, database: db, startupProfile: saved);
    await tapVisible(tester, find.text('Perfil'));
  }

  ThemeMode appThemeMode(WidgetTester tester) =>
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!;

  testWidgets('changes and saves the language', (tester) async {
    await openProfile(tester);
    await tapVisible(tester, find.text('Idioma'));
    await tapVisible(tester, find.text('Catalán'));

    expect(find.text('Preferències'), findsOneWidget);
    expect(find.text('Català'), findsOneWidget);
    final saved = (await tester.runAsync(profiles.getProfile))!;
    expect(saved.locale, 'ca');
  });

  testWidgets('changes and saves the theme', (tester) async {
    await openProfile(tester);
    expect(appThemeMode(tester), ThemeMode.system);

    await tapVisible(tester, find.text('Tema'));
    await tapVisible(tester, find.text('Oscuro'));

    expect(appThemeMode(tester), ThemeMode.dark);
    expect(find.text('Oscuro'), findsOneWidget);
    final saved = (await tester.runAsync(profiles.getProfile))!;
    expect(saved.themeMode, AppThemeMode.dark);
  });

  testWidgets('starts with the saved theme', (tester) async {
    final dark = onboardedProfile();
    await tester.runAsync(() async {
      await profiles.saveProfile(dark);
      await profiles.updatePreferences(themeMode: AppThemeMode.light);
    });
    final saved = (await tester.runAsync(profiles.getProfile))!;
    await pumpApp(tester, database: db, startupProfile: saved);
    expect(appThemeMode(tester), ThemeMode.light);
  });

  test('retaking the questionnaire keeps the theme', () async {
    final repo = OnboardingRepository(
      db,
      profiles,
      GoalsRepository(db.goalsDao),
    );
    const answers = OnboardingAnswers(
      legalAccepted: true,
      ageRange: AgeRange.from21To25,
      employment: Employment.permanent,
      hasDependents: false,
      hasHighInterestDebt: false,
      riskAnswers: [2, 2, 2, 2],
      knowledgeLevel: KnowledgeLevel.basic,
    );
    const names = (emergency: 'F', housing: 'H', retirement: 'R');
    await repo.complete(answers, locale: 'es', names: names);
    await profiles.updatePreferences(themeMode: AppThemeMode.dark);
    await repo.complete(answers, locale: 'es', names: names);

    expect((await profiles.getProfile())!.themeMode, AppThemeMode.dark);
    await db.close();
  });
}
