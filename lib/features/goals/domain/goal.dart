import 'goal_type.dart';

class Goal {
  const Goal({
    this.id,
    required this.type,
    required this.name,
    required this.targetCents,
    this.targetDate,
    this.expectedAnnualReturn = 0,
    this.params = const {},
    required this.createdAt,
  });

  /// `null` until persisted.
  final int? id;
  final GoalType type;
  final String name;
  final int targetCents;

  /// UTC; optional for the emergency fund.
  final DateTime? targetDate;

  /// Ratio, e.g. `0.05` for 5 %.
  final double expectedAnnualReturn;

  /// Type-specific inputs (home price, retirement age…), stored as JSON.
  final Map<String, Object?> params;

  /// UTC.
  final DateTime createdAt;

  Goal copyWith({
    String? name,
    int? targetCents,
    DateTime? Function()? targetDate,
    double? expectedAnnualReturn,
    Map<String, Object?>? params,
  }) => Goal(
    id: id,
    type: type,
    name: name ?? this.name,
    targetCents: targetCents ?? this.targetCents,
    targetDate: targetDate != null ? targetDate() : this.targetDate,
    expectedAnnualReturn: expectedAnnualReturn ?? this.expectedAnnualReturn,
    params: params ?? this.params,
    createdAt: createdAt,
  );
}
