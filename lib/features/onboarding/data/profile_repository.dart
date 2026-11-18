import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/db/app_database.dart';
import '../../../core/domain/app_theme_mode.dart';
import '../../profile/domain/contribution_reminder.dart';
import '../domain/user_profile.dart';
import 'profile_dao.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  const ProfileRepository(this._dao);

  final ProfileDao _dao;

  Future<UserProfile?> getProfile() async =>
      (await _dao.getProfile())?.toDomain();

  Stream<UserProfile?> watchProfile() =>
      _dao.watchProfile().map((row) => row?.toDomain());

  /// Creates or replaces the profile and returns its id.
  Future<int> saveProfile(UserProfile profile) =>
      _dao.saveProfile(profile.toCompanion());

  /// Saves language and/or theme without touching the other answers.
  Future<void> updatePreferences({String? locale, AppThemeMode? themeMode}) =>
      _dao.updatePreferences(
        UserProfilesCompanion(
          locale: locale == null ? const Value.absent() : Value(locale),
          themeMode: themeMode == null
              ? const Value.absent()
              : Value(themeMode),
        ),
      );

  /// Saves the contribution reminder; `null` turns it off.
  Future<void> updateReminder(ContributionReminder? reminder) =>
      _dao.updatePreferences(
        UserProfilesCompanion(
          reminderDay: Value(reminder?.dayOfMonth),
          reminderMinuteOfDay: reminder == null
              ? const Value.absent()
              : Value(reminder.minuteOfDay),
        ),
      );

  Future<void> updateAppLock({required bool enabled}) => _dao.updatePreferences(
    UserProfilesCompanion(appLockEnabled: Value(enabled)),
  );

  Future<List<MonthlyExpense>> getExpenses() async =>
      (await _dao.getExpenses()).map((r) => r.toDomain()).toList();

  Stream<List<MonthlyExpense>> watchExpenses() => _dao.watchExpenses().map(
    (rows) => rows.map((r) => r.toDomain()).toList(),
  );

  Future<void> replaceExpenses(List<MonthlyExpense> expenses) =>
      _dao.replaceExpenses([
        for (final e in expenses)
          MonthlyExpensesCompanion.insert(
            category: e.category,
            amountCents: e.amountCents,
          ),
      ]);
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepository(ref.watch(appDatabaseProvider).profileDao);

extension on UserProfileRow {
  UserProfile toDomain() => UserProfile(
    id: id,
    ageRange: ageRange,
    employment: employment,
    monthlyIncomeCents: monthlyIncomeCents,
    hasDependents: hasDependents,
    hasHighInterestDebt: hasHighInterestDebt,
    debtCents: debtCents,
    riskScore: riskScore,
    riskProfile: riskProfile,
    knowledgeLevel: knowledgeLevel,
    emergencyMonths: emergencyMonths,
    locale: locale,
    onboardingCompletedAt: onboardingCompletedAt,
    themeMode: themeMode,
    reminder: switch (reminderDay) {
      null => null,
      final day => ContributionReminder(
        dayOfMonth: day,
        minuteOfDay: reminderMinuteOfDay,
      ),
    },
    appLockEnabled: appLockEnabled,
  );
}

extension on MonthlyExpenseRow {
  MonthlyExpense toDomain() =>
      MonthlyExpense(category: category, amountCents: amountCents);
}

extension on UserProfile {
  UserProfilesCompanion toCompanion() => UserProfilesCompanion.insert(
    ageRange: ageRange,
    employment: employment,
    monthlyIncomeCents: Value(monthlyIncomeCents),
    hasDependents: hasDependents,
    hasHighInterestDebt: hasHighInterestDebt,
    debtCents: Value(debtCents),
    riskScore: riskScore,
    riskProfile: riskProfile,
    knowledgeLevel: knowledgeLevel,
    emergencyMonths: emergencyMonths,
    locale: locale,
    onboardingCompletedAt: Value(onboardingCompletedAt?.toUtc()),
  );
}
