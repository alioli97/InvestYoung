import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/db/app_database.dart';
import 'package:invest_young/features/goals/data/goals_repository.dart';
import 'package:invest_young/features/goals/domain/goal.dart';
import 'package:invest_young/features/goals/domain/goal_type.dart';
import 'package:invest_young/features/investments/data/investments_repository.dart';
import 'package:invest_young/features/investments/domain/asset.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';

import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late InvestmentsRepository repo;

  setUp(() {
    db = createTestDatabase();
    repo = InvestmentsRepository(db.investmentsDao);
  });

  tearDown(() => db.close());

  Asset asset(AssetCategory category, {String name = 'A', int? goalId}) =>
      Asset(
        category: category,
        name: name,
        goalId: goalId,
        metadata: const {'ticker': 'VWCE'},
        createdAt: DateTime.utc(2026, 1, 1),
      );

  AssetTransaction tx(int assetId, DateTime date, {Decimal? quantity}) =>
      AssetTransaction(
        assetId: assetId,
        type: TransactionType.buy,
        date: date,
        amountCents: 10000,
        quantity: quantity,
        feeCents: 100,
      );

  test('filters assets by category and archived flag', () async {
    final equityId = await repo.addAsset(asset(AssetCategory.equity));
    await repo.addAsset(asset(AssetCategory.crypto));

    expect(await repo.getAssets(), hasLength(2));
    expect(
      (await repo.getAssets(category: AssetCategory.equity)).single.id,
      equityId,
    );

    await repo.setArchived(equityId, archived: true);
    expect(await repo.getAssets(), hasLength(1));
    expect(await repo.getAssets(includeArchived: true), hasLength(2));
  });

  test('filters assets by goal', () async {
    final goalId = await GoalsRepository(db.goalsDao).addGoal(
      Goal(
        type: GoalType.emergency,
        name: 'Fondo',
        targetCents: 1,
        createdAt: DateTime.utc(2026),
      ),
    );
    await repo.addAsset(asset(AssetCategory.emergency, goalId: goalId));
    await repo.addAsset(asset(AssetCategory.equity));

    final assigned = await repo.getAssets(goalId: goalId);
    expect(assigned.single.category, AssetCategory.emergency);
  });

  test('round-trips metadata and updates assets', () async {
    final id = await repo.addAsset(asset(AssetCategory.equity));
    final stored = await repo.getAsset(id);
    expect(stored!.metadata['ticker'], 'VWCE');

    await repo.updateAsset(
      Asset(
        id: id,
        category: AssetCategory.equity,
        name: 'Renamed',
        createdAt: stored.createdAt,
      ),
    );
    expect((await repo.getAsset(id))!.name, 'Renamed');
  });

  test(
    'transactions are ordered by date and keep Decimal quantities',
    () async {
      final id = await repo.addAsset(asset(AssetCategory.crypto));
      await repo.addTransaction(tx(id, DateTime.utc(2026, 3, 1)));
      await repo.addTransaction(
        tx(id, DateTime.utc(2026, 1, 1), quantity: Decimal.parse('0.015')),
      );

      final list = await repo.getTransactions(assetId: id);
      expect(list.map((t) => t.date), [
        DateTime.utc(2026, 1, 1),
        DateTime.utc(2026, 3, 1),
      ]);
      expect(list.first.quantity, Decimal.parse('0.015'));
      expect(list.first.feeCents, 100);
    },
  );

  test('deleting an asset removes its transactions', () async {
    final id = await repo.addAsset(asset(AssetCategory.equity));
    final otherId = await repo.addAsset(asset(AssetCategory.equity));
    await repo.addTransaction(tx(id, DateTime.utc(2026)));
    await repo.addTransaction(tx(otherId, DateTime.utc(2026)));

    await repo.deleteAsset(id);
    final remaining = await repo.getTransactions();
    expect(remaining.single.assetId, otherId);
  });

  test('updates and deletes transactions', () async {
    final assetId = await repo.addAsset(asset(AssetCategory.equity));
    final txId = await repo.addTransaction(tx(assetId, DateTime.utc(2026)));

    await repo.updateTransaction(
      AssetTransaction(
        id: txId,
        assetId: assetId,
        type: TransactionType.valuation,
        date: DateTime.utc(2026, 2),
        amountCents: 12345,
      ),
    );
    final updated = (await repo.getTransactions()).single;
    expect(updated.type, TransactionType.valuation);
    expect(updated.quantity, isNull);

    await repo.deleteTransaction(txId);
    expect(await repo.getTransactions(), isEmpty);
  });
}
