import '../../../core/domain/db_enum.dart';

enum AssetCategory implements DbEnum {
  emergency('emergency'),
  fixedIncome('fixed_income'),
  equity('equity'),
  crypto('crypto');

  const AssetCategory(this.dbValue);

  @override
  final String dbValue;
}

enum TransactionType implements DbEnum {
  deposit('deposit'),
  withdrawal('withdrawal'),
  buy('buy'),
  sell('sell'),
  income('income'),
  valuation('valuation');

  const TransactionType(this.dbValue);

  @override
  final String dbValue;
}
