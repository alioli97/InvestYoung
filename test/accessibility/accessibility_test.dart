import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/core/domain/app_theme_mode.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/test_database.dart';

/// Basic accessibility audit of the main screens: Flutter's tap target,
/// label and contrast guidelines in light and dark themes, and no layout
/// overflow with large text.
void main() {
  late AppDatabase db;

  Future<void> seed(WidgetTester tester, AppThemeMode theme) =>
      tester.runAsync(() async {
        final profiles = ProfileRepository(db.profileDao);
        await profiles.saveProfile(onboardedProfile());
        await profiles.updatePreferences(themeMode: theme);
        final goals = GoalsRepository(db.goalsDao);
        final emergency = await goals.addGoal(
          Goal(
            type: GoalType.emergency,
            name: 'Fondo de emergencia',
            targetCents: 500000,
            createdAt: DateTime.utc(2026),
          ),
        );
        final investments = InvestmentsRepository(db.investmentsDao);
        final id = await investments.addAsset(
          testAsset(AssetCategory.emergency, name: 'Cuenta', goalId: emergency),
        );
        await investments.addTransaction(
          testTx(id, TransactionType.deposit, 200000),
        );
        final fund = await investments.addAsset(
          testAsset(AssetCategory.equity, name: 'Fondo'),
        );
        await investments.addTransaction(
          testTx(fund, TransactionType.buy, 100000, quantity: '1'),
        );
      });

  /// Tab label → a text that proves the screen has loaded.
  const tabs = {
    'Inicio': 'Patrimonio total',
    'Objetivos': 'Fondo de emergencia',
    'Inversiones': 'Valor total',
    'Aprender': 'Fundamentos',
    'Perfil': 'Preferencias',
  };

  Future<void> openTab(WidgetTester tester, String tab) async {
    await tester.tap(find.text(tab).last);
    await tester.pump();
    await pumpUntilFound(tester, find.text(tabs[tab]!).first);
  }

  for (final theme in [AppThemeMode.light, AppThemeMode.dark]) {
    testWidgets('main screens meet the guidelines (${theme.name})', (
      tester,
    ) async {
      db = createTestDatabase();
      await seed(tester, theme);
      final profile = (await tester.runAsync(
        ProfileRepository(db.profileDao).getProfile,
      ))!;
      final handle = tester.ensureSemantics();
      await pumpApp(tester, database: db, startupProfile: profile);

      for (final tab in tabs.keys) {
        await openTab(tester, tab);
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
      }
      handle.dispose();
    });
  }

  testWidgets('main screens do not overflow with 200 % text', (tester) async {
    db = createTestDatabase();
    await seed(tester, AppThemeMode.system);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());

    for (final tab in tabs.keys) {
      await openTab(tester, tab);
      expect(tester.takeException(), isNull, reason: tab);
    }

    // Inner screens: category list, asset detail, goal detail, goal form.
    Future<void> open(String text, String reason) async {
      if (find.text(text).evaluate().isEmpty) {
        await tester.scrollUntilVisible(
          find.text(text),
          200,
          scrollable: find.byType(Scrollable).first,
        );
      }
      // Built but off-screen widgets cannot be tapped: bring it into view.
      await tester.ensureVisible(find.text(text).first);
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text(text).first);
      await tester.pump();
      await pumpUntilFound(tester, find.byType(BackButton));
      expect(tester.takeException(), isNull, reason: reason);
    }

    await openTab(tester, 'Inversiones');
    await open('Renta variable', 'category list');
    await open('Fondo', 'asset detail');
    await openTab(tester, 'Objetivos');
    await open('Fondo de emergencia', 'goal detail');
    await tester.tap(find.byTooltip('Editar objetivo'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'goal form');
  });

  testWidgets('onboarding meets the guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpApp(tester);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
