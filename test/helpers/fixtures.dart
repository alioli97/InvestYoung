import 'package:decimal/decimal.dart';
import 'package:invest_young/features/investments/domain/asset.dart';
import 'package:invest_young/features/investments/domain/asset_transaction.dart';
import 'package:invest_young/features/investments/domain/investment_enums.dart';
import 'package:invest_young/features/onboarding/domain/profile_enums.dart';
import 'package:invest_young/features/onboarding/domain/user_profile.dart';

/// A completed onboarding profile, so the app starts on the tabs.
UserProfile onboardedProfile({String locale = 'es'}) => UserProfile(
  ageRange: AgeRange.from26To30,
  employment: Employment.permanent,
  hasDependents: false,
  hasHighInterestDebt: false,
  riskScore: 8,
  riskProfile: RiskProfile.moderate,
  knowledgeLevel: KnowledgeLevel.basic,
  emergencyMonths: 5,
  locale: locale,
  onboardingCompletedAt: DateTime.utc(2026),
);

Asset testAsset(
  AssetCategory category, {
  int? id,
  String name = 'Activo',
  Map<String, Object?> metadata = const {},
  int? goalId,
}) => Asset(
  id: id,
  category: category,
  name: name,
  metadata: metadata,
  goalId: goalId,
  createdAt: DateTime.utc(2026, 1, 1),
);

AssetTransaction testTx(
  int assetId,
  TransactionType type,
  int amountCents, {
  int day = 1,
  String? quantity,
  int? feeCents,
}) => AssetTransaction(
  assetId: assetId,
  type: type,
  date: DateTime.utc(2026, 1, day),
  amountCents: amountCents,
  quantity: quantity == null ? null : Decimal.parse(quantity),
  feeCents: feeCents,
);
