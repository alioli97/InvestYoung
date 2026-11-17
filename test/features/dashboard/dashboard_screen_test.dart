import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/goals/presentation/widgets/goal_progress_card.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  Future<void> seed(WidgetTester tester, {required int savingsCents}) =>
      tester.runAsync(() async {
        final goals = GoalsRepository(db.goalsDao);
        final investments = InvestmentsRepository(db.investmentsDao);
        await goals.addGoal(
          Goal(
            type: GoalType.housing,
            name: 'Piso',
            targetCents: 2000000,
            createdAt: DateTime.utc(2026),
          ),
        );
        await goals.addGoal(
          Goal(
            type: GoalType.emergency,
            name: 'Fondo de emergencia',
            targetCents: 500000,
            createdAt: DateTime.utc(2026, 2),
          ),
        );
        final savings = await investments.addAsset(
          testAsset(AssetCategory.emergency, name: 'Cuenta'),
        );
        await investments.addTransaction(
          testTx(savings, TransactionType.deposit, savingsCents),
        );
        final fund = await investments.addAsset(
          testAsset(AssetCategory.equity, name: 'Fondo'),
        );
        await investments.addTransaction(
          testTx(fund, TransactionType.buy, 100000, quantity: '1'),
        );
      });

  testWidgets('shows net worth, goals, allocation and a tip', (tester) async {
    await seed(tester, savingsCents: 300000);
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Patrimonio total'), findsOneWidget);
    expect(findMoney('4.000,00 €'), findsOneWidget);

    // Emergency fund first and highlighted while incomplete.
    final cards = tester.widgetList<GoalProgressCard>(
      find.byType(GoalProgressCard),
    );
    expect(cards.first.progress.goal.type, GoalType.emergency);
    expect(cards.first.highlighted, isTrue);
    expect(cards.last.highlighted, isFalse);

    await tester.scrollUntilVisible(find.byType(PieChart), 200);
    expect(find.text('Reparto por categoría'), findsOneWidget);
    expect(findMoney('75 %'), findsOneWidget);
    expect(findMoney('25 %'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Consejo del día'), 200);
    expect(find.text('Consejo del día'), findsOneWidget);
  });

  testWidgets('complete emergency fund is not highlighted', (tester) async {
    await seed(tester, savingsCents: 500000);
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());

    final card = tester.widget<GoalProgressCard>(
      find.byType(GoalProgressCard).first,
    );
    expect(card.progress.isComplete, isTrue);
    expect(card.highlighted, isFalse);
  });

  testWidgets('without investments it invites to add one', (tester) async {
    await pumpApp(tester, database: db, startupProfile: onboardedProfile());

    expect(findMoney('0,00 €'), findsOneWidget);
    expect(find.byType(PieChart), findsNothing);
    await tapVisible(
      tester,
      find.text('Añade tu primera inversión para ver tu reparto'),
    );
    expect(find.text('Valor total'), findsOneWidget);
  });
}
