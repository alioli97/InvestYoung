// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dao.dart';

// ignore_for_file: type=lint
mixin _$ProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserProfilesTable get userProfiles => attachedDatabase.userProfiles;
  $MonthlyExpensesTable get monthlyExpenses => attachedDatabase.monthlyExpenses;
  ProfileDaoManager get managers => ProfileDaoManager(this);
}

class ProfileDaoManager {
  final _$ProfileDaoMixin _db;
  ProfileDaoManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db.attachedDatabase, _db.userProfiles);
  $$MonthlyExpensesTableTableManager get monthlyExpenses =>
      $$MonthlyExpensesTableTableManager(
        _db.attachedDatabase,
        _db.monthlyExpenses,
      );
}
