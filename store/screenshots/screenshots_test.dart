// Google Play screenshots, rendered from the real screens with sample data.
//
// Not part of the regular test suite (CI only runs test/). Regenerate with:
//   flutter test store/screenshots/screenshots_test.dart --update-goldens
// The PNGs land in store/screenshots/{es,ca}/ (1080×1920, 9:16).
//
// Text needs real fonts: Roboto and Material Icons are loaded from the Flutter
// SDK cache (bin/cache/artifacts/material_fonts).

import 'dart:io';

import 'package:decimal/decimal.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_params.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/data/profile_repository.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';
import 'package:material_ui/material_ui.dart';

import '../../test/helpers/fixtures.dart';
import '../../test/helpers/pump_app.dart';
import '../../test/helpers/test_database.dart';

const _size = Size(1080, 1920);
const _pixelRatio = 2.625; // A common Android density: 411×731 logical px.

Future<void> _loadFonts() async {
  // The test runs inside the SDK's flutter_tester; walk up to find the fonts.
  Directory? dir;
  for (
    var d = File(Platform.resolvedExecutable).parent;
    d.parent.path != d.path;
    d = d.parent
  ) {
    for (final sub in ['material_fonts', 'artifacts/material_fonts']) {
      final candidate = Directory('${d.path}/$sub');
      if (candidate.existsSync()) dir = candidate;
    }
    if (dir != null) break;
  }
  if (dir == null) throw StateError('Material fonts not found in the SDK');
  final fonts = dir;
  Future<ByteData> read(String name) async =>
      ByteData.sublistView(await File('${fonts.path}/$name').readAsBytes());

  final roboto = FontLoader('Roboto');
  for (final w in ['Light', 'Regular', 'Medium', 'Bold']) {
    roboto.addFont(read('Roboto-$w.ttf'));
  }
  await roboto.load();
  await (FontLoader(
    'MaterialIcons',
  )..addFont(read('MaterialIcons-Regular.otf'))).load();
}

typedef _Names = ({
  String emergency,
  String housing,
  String retirement,
  String account,
  String bills,
  String fund,
});

const _es = (
  emergency: 'Fondo de emergencia',
  housing: 'Mi primera casa',
  retirement: 'Jubilación',
  account: 'Cuenta remunerada',
  bills: 'Letras del Tesoro',
  fund: 'Fondo indexado global',
);
const _ca = (
  emergency: "Fons d'emergència",
  housing: 'La meva primera casa',
  retirement: 'Jubilació',
  account: 'Compte remunerat',
  bills: 'Lletres del Tresor',
  fund: 'Fons indexat global',
);

/// A 28-year-old saving for a first home: 960 €/month of expenses, three goals
/// and four investments. Generic product types only (no real products).
Future<void> _seed(AppDatabase db, String locale, _Names n) async {
  final profiles = ProfileRepository(db.profileDao);
  await profiles.saveProfile(onboardedProfile(locale: locale));
  await profiles.replaceExpenses(const [
    MonthlyExpense(category: ExpenseCategory.housing, amountCents: 60000),
    MonthlyExpense(category: ExpenseCategory.food, amountCents: 25000),
    MonthlyExpense(category: ExpenseCategory.transport, amountCents: 8000),
    MonthlyExpense(category: ExpenseCategory.subscriptions, amountCents: 3000),
  ]);

  final goals = GoalsRepository(db.goalsDao);
  final now = DateTime.now().toUtc();
  Future<int> goal(
    GoalType type,
    String name,
    Map<String, Object?> params, {
    DateTime? targetDate,
    double expectedReturn = 0,
  }) => goals.addGoal(
    Goal(
      type: type,
      name: name,
      targetCents: GoalParams.computeTarget(
        type,
        params,
        monthlyExpensesCents: 96000,
      )!,
      targetDate: targetDate,
      expectedAnnualReturn: expectedReturn,
      params: params,
      createdAt: now,
    ),
  );
  final emergency = await goal(GoalType.emergency, n.emergency, {
    GoalParams.months: 5,
  });
  final housing = await goal(
    GoalType.housing,
    n.housing,
    {
      GoalParams.homePriceCents: 18000000,
      GoalParams.downPaymentPct: 0.20,
      GoalParams.feesPct: 0.10,
    },
    targetDate: DateTime.utc(now.year + 6, 6),
    expectedReturn: 0.04,
  );
  await goal(GoalType.retirement, n.retirement, {
    GoalParams.currentAge: 28,
    GoalParams.retirementAge: 67,
    GoalParams.monthlySpendingCents: 150000,
  }, expectedReturn: 0.05);

  final investments = InvestmentsRepository(db.investmentsDao);
  DateTime ago(int months) => DateTime.utc(now.year, now.month - months, 5);
  Future<void> add(
    AssetCategory category,
    String name,
    int? goalId,
    List<(TransactionType, int, int, String?)> txs,
  ) async {
    final id = await investments.addAsset(
      testAsset(category, name: name, goalId: goalId),
    );
    for (final (type, cents, monthsAgo, quantity) in txs) {
      await investments.addTransaction(
        AssetTransaction(
          assetId: id,
          type: type,
          date: ago(monthsAgo),
          amountCents: cents,
          quantity: quantity == null ? null : Decimal.parse(quantity),
        ),
      );
    }
  }

  await add(AssetCategory.emergency, n.account, emergency, [
    (TransactionType.deposit, 250000, 10, null),
    (TransactionType.deposit, 70000, 4, null),
    (TransactionType.income, 3800, 1, null),
  ]);
  await add(AssetCategory.fixedIncome, n.bills, housing, [
    (TransactionType.buy, 200000, 7, '2'),
  ]);
  await add(AssetCategory.equity, n.fund, housing, [
    (TransactionType.buy, 300000, 12, '31.25'),
    (TransactionType.buy, 150000, 5, '14.80'),
    (TransactionType.valuation, 492000, 0, null),
  ]);
  await add(AssetCategory.crypto, 'Bitcoin', null, [
    (TransactionType.buy, 30000, 8, '0.0041'),
  ]);
}

void main() {
  setUpAll(_loadFonts);

  for (final (locale, names) in [('es', _es), ('ca', _ca)]) {
    testWidgets('screenshots ($locale)', (tester) async {
      // flutter_test draws elevation shadows as solid black outlines; render
      // real ones (restored at the end: the framework checks it is reset).
      debugDisableShadows = false;
      final db = createTestDatabase();
      await tester.runAsync(() => _seed(db, locale, names));
      await pumpApp(
        tester,
        locale: Locale(locale),
        size: _size,
        database: db,
        startupProfile: onboardedProfile(locale: locale),
      );
      tester.view.devicePixelRatio = _pixelRatio;
      // Touch mode, as on a phone: no keyboard focus rings after taps.
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      addTearDown(
        () => FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.automatic,
      );
      await tester.pumpAndSettle();

      Future<void> shot(String name) async {
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$locale/$name.png'),
        );
      }

      Future<void> tab(int index) async {
        await tester.tap(find.byType(NavigationDestination).at(index));
        await tester.pumpAndSettle();
      }

      await shot('1_home');
      await tab(1);
      await shot('2_goals');
      await tester.tap(find.text(names.housing).first);
      await tester.pumpAndSettle();
      await shot('3_housing_goal');
      await tab(2);
      await shot('4_investments');
      await tab(3);
      await shot('5_learn');
      debugDisableShadows = true;
    });
  }
}
