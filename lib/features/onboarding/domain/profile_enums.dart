import '../../../core/domain/db_enum.dart';

enum AgeRange implements DbEnum {
  from16To20('16_20'),
  from21To25('21_25'),
  from26To30('26_30'),
  from31To35('31_35'),
  over35('35_plus');

  const AgeRange(this.dbValue);

  @override
  final String dbValue;
}

enum Employment implements DbEnum {
  permanent('permanent'),
  temporary('temporary'),
  selfEmployed('self_employed'),
  student('student'),
  unemployed('unemployed');

  const Employment(this.dbValue);

  @override
  final String dbValue;
}

enum RiskProfile implements DbEnum {
  conservative('conservative'),
  moderate('moderate'),
  aggressive('aggressive');

  const RiskProfile(this.dbValue);

  @override
  final String dbValue;
}

enum KnowledgeLevel implements DbEnum {
  none('none'),
  basic('basic'),
  intermediate('intermediate');

  const KnowledgeLevel(this.dbValue);

  @override
  final String dbValue;
}

/// Monthly expense categories asked in onboarding step 3.
enum ExpenseCategory implements DbEnum {
  /// Rent or mortgage and utilities.
  housing('housing'),
  food('food'),
  transport('transport'),
  insurance('insurance'),
  subscriptions('subscriptions'),
  otherFixed('other_fixed');

  const ExpenseCategory(this.dbValue);

  @override
  final String dbValue;
}
