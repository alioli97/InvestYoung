import 'package:drift/drift.dart';

import '../../features/goals/domain/goal_type.dart';
import '../domain/app_theme_mode.dart';
import '../../features/investments/domain/investment_enums.dart';
import '../../features/onboarding/domain/profile_enums.dart';
import 'converters.dart';

// Schema from docs/SPEC.md §10. Money is stored as integer cents, non-monetary
// quantities as Decimal TEXT and dates as UTC (ISO-8601 text, see build.yaml).
// Row classes use a `Row` suffix so domain models can keep the plain names.

@DataClassName('UserProfileRow')
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ageRange =>
      text().map(const DbEnumConverter(AgeRange.values))();
  TextColumn get employment =>
      text().map(const DbEnumConverter(Employment.values))();
  IntColumn get monthlyIncomeCents => integer().nullable()();
  BoolColumn get hasDependents => boolean()();
  BoolColumn get hasHighInterestDebt => boolean()();
  IntColumn get debtCents => integer().nullable()();
  IntColumn get riskScore => integer()();
  TextColumn get riskProfile =>
      text().map(const DbEnumConverter(RiskProfile.values))();
  TextColumn get knowledgeLevel =>
      text().map(const DbEnumConverter(KnowledgeLevel.values))();
  IntColumn get emergencyMonths => integer()();
  TextColumn get locale => text()();
  DateTimeColumn get onboardingCompletedAt => dateTime().nullable()();

  /// Added in schema v2.
  TextColumn get themeMode => text()
      .map(const DbEnumConverter(AppThemeMode.values))
      .withDefault(const Constant('system'))();

  /// Added in schema v3: day of the month (1–28) of the contribution
  /// reminder, `null` when it is off.
  IntColumn get reminderDay => integer().nullable()();

  /// Added in schema v3: local time of the reminder, in minutes after
  /// midnight (default 9:00).
  IntColumn get reminderMinuteOfDay =>
      integer().withDefault(const Constant(540))();
}

@DataClassName('MonthlyExpenseRow')
class MonthlyExpenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category =>
      text().map(const DbEnumConverter(ExpenseCategory.values))();
  IntColumn get amountCents => integer()();
}

@DataClassName('GoalRow')
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().map(const DbEnumConverter(GoalType.values))();
  TextColumn get name => text()();
  IntColumn get targetCents => integer()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  RealColumn get expectedAnnualReturn =>
      real().withDefault(const Constant(0.0))();
  TextColumn get paramsJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('AssetRow')
class Assets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category =>
      text().map(const DbEnumConverter(AssetCategory.values))();
  TextColumn get name => text()();
  IntColumn get goalId => integer().nullable().references(
    Goals,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get metadataJson => text().withDefault(const Constant('{}'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

@DataClassName('TransactionRow')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get assetId =>
      integer().references(Assets, #id, onDelete: KeyAction.cascade)();
  TextColumn get type =>
      text().map(const DbEnumConverter(TransactionType.values))();
  DateTimeColumn get date => dateTime()();
  IntColumn get amountCents => integer()();
  TextColumn get quantity => text().map(const DecimalConverter()).nullable()();
  IntColumn get feeCents => integer().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('LessonProgressRow')
class LessonProgress extends Table {
  TextColumn get lessonId => text()();
  DateTimeColumn get readAt => dateTime().nullable()();
  DateTimeColumn get quizPassedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {lessonId};
}
