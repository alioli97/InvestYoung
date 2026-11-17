// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_dao.dart';

// ignore_for_file: type=lint
mixin _$InvestmentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => attachedDatabase.goals;
  $AssetsTable get assets => attachedDatabase.assets;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  InvestmentsDaoManager get managers => InvestmentsDaoManager(this);
}

class InvestmentsDaoManager {
  final _$InvestmentsDaoMixin _db;
  InvestmentsDaoManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db.attachedDatabase, _db.assets);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
}
