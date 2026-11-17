import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [UserProfiles, MonthlyExpenses])
class ProfileDao extends DatabaseAccessor<AppDatabase> with _$ProfileDaoMixin {
  ProfileDao(super.attachedDatabase);

  Future<UserProfileRow?> getProfile() =>
      (select(userProfiles)..limit(1)).getSingleOrNull();

  Stream<UserProfileRow?> watchProfile() =>
      (select(userProfiles)..limit(1)).watchSingleOrNull();

  /// Inserts the profile, or replaces it if one exists (single-profile app).
  Future<int> saveProfile(UserProfilesCompanion profile) {
    return transaction(() async {
      final existing = await getProfile();
      if (existing == null) return into(userProfiles).insert(profile);
      await (update(userProfiles)..where((p) => p.id.equals(existing.id)))
          .write(profile.copyWith(id: Value(existing.id)));
      return existing.id;
    });
  }

  Future<List<MonthlyExpenseRow>> getExpenses() =>
      (select(monthlyExpenses)..orderBy([(e) => OrderingTerm.asc(e.id)])).get();

  Stream<List<MonthlyExpenseRow>> watchExpenses() => (select(
    monthlyExpenses,
  )..orderBy([(e) => OrderingTerm.asc(e.id)])).watch();

  /// Replaces every monthly expense with [expenses].
  Future<void> replaceExpenses(List<MonthlyExpensesCompanion> expenses) {
    return transaction(() async {
      await delete(monthlyExpenses).go();
      await batch((b) => b.insertAll(monthlyExpenses, expenses));
    });
  }
}
