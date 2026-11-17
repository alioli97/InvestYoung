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

  static String editAsset(int assetId) => '$investments/asset/$assetId/edit';
}
