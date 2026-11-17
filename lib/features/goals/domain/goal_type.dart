import '../../../core/domain/db_enum.dart';

enum GoalType implements DbEnum {
  emergency('emergency'),
  housing('housing'),
  retirement('retirement'),
  custom('custom');

  const GoalType(this.dbValue);

  @override
  final String dbValue;
}
