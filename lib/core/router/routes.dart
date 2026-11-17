import '../../features/goals/domain/goal_type.dart';
import '../../features/investments/domain/investment_enums.dart';

/// Route paths used across the app.
abstract final class Routes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const goals = '/goals';
  static const investments = '/investments';
  static const learn = '/learn';
  static const profile = '/profile';
  static const retakeOnboarding = '/retake-onboarding';

  /// Assets of one investment category.
  static String investmentCategory(AssetCategory category) =>
      '$investments/category/${category.dbValue}';

  static String newAsset(AssetCategory category) =>
      '${investmentCategory(category)}/new';

  static String asset(int assetId) => '$investments/asset/$assetId';

  static String editAsset(int assetId) => '${asset(assetId)}/edit';

  static String newTransaction(int assetId) =>
      '${asset(assetId)}/transaction/new';

  static String editTransaction(int assetId, int transactionId) =>
      '${asset(assetId)}/transaction/$transactionId';

  static String goal(int goalId) => '$goals/$goalId';

  static String editGoal(int goalId) => '${goal(goalId)}/edit';

  static String newGoal(GoalType type) => '$goals/new/${type.dbValue}';
}
