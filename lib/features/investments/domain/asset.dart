import 'investment_enums.dart';

class Asset {
  const Asset({
    this.id,
    required this.category,
    required this.name,
    this.goalId,
    this.metadata = const {},
    this.notes,
    required this.createdAt,
    this.archived = false,
  });

  /// `null` until persisted.
  final int? id;
  final AssetCategory category;
  final String name;
  final int? goalId;

  /// Category-specific fields (institution, APY, ticker, symbol…), stored as JSON.
  final Map<String, Object?> metadata;
  final String? notes;

  /// UTC.
  final DateTime createdAt;
  final bool archived;
}
