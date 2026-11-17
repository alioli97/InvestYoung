import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';
import '../domain/investment_enums.dart';

part 'investments_dao.g.dart';

@DriftAccessor(tables: [Assets, Transactions])
class InvestmentsDao extends DatabaseAccessor<AppDatabase>
    with _$InvestmentsDaoMixin {
  InvestmentsDao(super.attachedDatabase);

  // Assets

  SimpleSelectStatement<$AssetsTable, AssetRow> _assets({
    AssetCategory? category,
    int? goalId,
    bool includeArchived = false,
  }) {
    final query = select(assets);
    if (category != null) {
      query.where((a) => a.category.equalsValue(category));
    }
    if (goalId != null) query.where((a) => a.goalId.equals(goalId));
    if (!includeArchived) query.where((a) => a.archived.equals(false));
    return query..orderBy([(a) => OrderingTerm.asc(a.createdAt)]);
  }

  Future<List<AssetRow>> getAssets({
    AssetCategory? category,
    int? goalId,
    bool includeArchived = false,
  }) => _assets(
    category: category,
    goalId: goalId,
    includeArchived: includeArchived,
  ).get();

  Stream<List<AssetRow>> watchAssets({
    AssetCategory? category,
    int? goalId,
    bool includeArchived = false,
  }) => _assets(
    category: category,
    goalId: goalId,
    includeArchived: includeArchived,
  ).watch();

  Future<AssetRow?> getAsset(int id) =>
      (select(assets)..where((a) => a.id.equals(id))).getSingleOrNull();

  Stream<AssetRow?> watchAsset(int id) =>
      (select(assets)..where((a) => a.id.equals(id))).watchSingleOrNull();

  Future<int> insertAsset(AssetsCompanion asset) => into(assets).insert(asset);

  Future<bool> updateAsset(int id, AssetsCompanion asset) async {
    final count = await (update(
      assets,
    )..where((a) => a.id.equals(id))).write(asset);
    return count > 0;
  }

  /// Deletes the asset and, via cascade, its transactions.
  Future<int> deleteAsset(int id) =>
      (delete(assets)..where((a) => a.id.equals(id))).go();

  // Transactions

  SimpleSelectStatement<$TransactionsTable, TransactionRow> _transactions(
    int? assetId,
  ) {
    final query = select(transactions);
    if (assetId != null) query.where((t) => t.assetId.equals(assetId));
    return query..orderBy([
      (t) => OrderingTerm.asc(t.date),
      (t) => OrderingTerm.asc(t.id),
    ]);
  }

  /// Transactions of [assetId] (or all when `null`), oldest first.
  Future<List<TransactionRow>> getTransactions({int? assetId}) =>
      _transactions(assetId).get();

  Stream<List<TransactionRow>> watchTransactions({int? assetId}) =>
      _transactions(assetId).watch();

  Future<int> insertTransaction(TransactionsCompanion tx) =>
      into(transactions).insert(tx);

  Future<bool> updateTransaction(int id, TransactionsCompanion tx) async {
    final count = await (update(
      transactions,
    )..where((t) => t.id.equals(id))).write(tx);
    return count > 0;
  }

  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();
}
