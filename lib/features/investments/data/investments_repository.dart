import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/json_columns.dart';
import '../domain/asset.dart';
import '../domain/asset_transaction.dart';
import '../domain/investment_enums.dart';
import 'investments_dao.dart';

part 'investments_repository.g.dart';

class InvestmentsRepository {
  const InvestmentsRepository(this._dao);

  final InvestmentsDao _dao;

  // Assets

  Future<List<Asset>> getAssets({
    AssetCategory? category,
    int? goalId,
    bool includeArchived = false,
  }) async => (await _dao.getAssets(
    category: category,
    goalId: goalId,
    includeArchived: includeArchived,
  )).map((r) => r.toDomain()).toList();

  Stream<List<Asset>> watchAssets({
    AssetCategory? category,
    int? goalId,
    bool includeArchived = false,
  }) => _dao
      .watchAssets(
        category: category,
        goalId: goalId,
        includeArchived: includeArchived,
      )
      .map((rows) => rows.map((r) => r.toDomain()).toList());

  Future<Asset?> getAsset(int id) async =>
      (await _dao.getAsset(id))?.toDomain();

  Stream<Asset?> watchAsset(int id) =>
      _dao.watchAsset(id).map((row) => row?.toDomain());

  /// Inserts a new asset ([Asset.id] is ignored) and returns its id.
  Future<int> addAsset(Asset asset) => _dao.insertAsset(asset.toCompanion());

  Future<bool> updateAsset(Asset asset) {
    final id = asset.id;
    if (id == null) throw ArgumentError('Cannot update an asset without id');
    return _dao.updateAsset(id, asset.toCompanion());
  }

  Future<bool> setArchived(int id, {required bool archived}) =>
      _dao.updateAsset(id, AssetsCompanion(archived: Value(archived)));

  /// Deletes the asset together with all its transactions.
  Future<void> deleteAsset(int id) => _dao.deleteAsset(id);

  // Transactions

  Future<List<AssetTransaction>> getTransactions({int? assetId}) async =>
      (await _dao.getTransactions(
        assetId: assetId,
      )).map((r) => r.toDomain()).toList();

  Stream<List<AssetTransaction>> watchTransactions({int? assetId}) => _dao
      .watchTransactions(assetId: assetId)
      .map((rows) => rows.map((r) => r.toDomain()).toList());

  /// Inserts a new transaction ([AssetTransaction.id] is ignored).
  Future<int> addTransaction(AssetTransaction tx) =>
      _dao.insertTransaction(tx.toCompanion());

  Future<bool> updateTransaction(AssetTransaction tx) {
    final id = tx.id;
    if (id == null) {
      throw ArgumentError('Cannot update a transaction without id');
    }
    return _dao.updateTransaction(id, tx.toCompanion());
  }

  Future<void> deleteTransaction(int id) => _dao.deleteTransaction(id);
}

@Riverpod(keepAlive: true)
InvestmentsRepository investmentsRepository(Ref ref) =>
    InvestmentsRepository(ref.watch(appDatabaseProvider).investmentsDao);

extension on AssetRow {
  Asset toDomain() => Asset(
    id: id,
    category: category,
    name: name,
    goalId: goalId,
    metadata: decodeJsonMap(metadataJson),
    notes: notes,
    createdAt: createdAt,
    archived: archived,
  );
}

extension on Asset {
  AssetsCompanion toCompanion() => AssetsCompanion.insert(
    category: category,
    name: name,
    goalId: Value(goalId),
    metadataJson: Value(encodeJsonMap(metadata)),
    notes: Value(notes),
    createdAt: createdAt.toUtc(),
    archived: Value(archived),
  );
}

extension on TransactionRow {
  AssetTransaction toDomain() => AssetTransaction(
    id: id,
    assetId: assetId,
    type: type,
    date: date,
    amountCents: amountCents,
    quantity: quantity,
    feeCents: feeCents,
    note: note,
  );
}

extension on AssetTransaction {
  TransactionsCompanion toCompanion() => TransactionsCompanion.insert(
    assetId: assetId,
    type: type,
    date: date.toUtc(),
    amountCents: amountCents,
    quantity: Value(quantity),
    feeCents: Value(feeCents),
    note: Value(note),
  );
}
