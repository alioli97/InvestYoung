import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../domain/investment_enums.dart';
import 'asset_form_screen.dart';
import 'category_assets_screen.dart';
import 'investments_screen.dart';

AssetCategory? _category(GoRouterState state) {
  final value = state.pathParameters['category'];
  for (final category in AssetCategory.values) {
    if (category.dbValue == value) return category;
  }
  return null;
}

String? _redirectUnknownCategory(GoRouterState state) =>
    _category(state) == null ? Routes.investments : null;

/// Routes of the Investments tab.
final investmentsRoute = GoRoute(
  path: Routes.investments,
  builder: (context, state) => const InvestmentsScreen(),
  routes: [
    GoRoute(
      path: 'category/:category',
      redirect: (context, state) => _redirectUnknownCategory(state),
      builder: (context, state) =>
          CategoryAssetsScreen(category: _category(state)!),
      routes: [
        GoRoute(
          path: 'new',
          redirect: (context, state) => _redirectUnknownCategory(state),
          builder: (context, state) =>
              AssetFormScreen.create(category: _category(state)!),
        ),
      ],
    ),
    GoRoute(
      path: 'asset/:assetId/edit',
      redirect: (context, state) =>
          int.tryParse(state.pathParameters['assetId']!) == null
          ? Routes.investments
          : null,
      builder: (context, state) => AssetFormScreen.edit(
        assetId: int.parse(state.pathParameters['assetId']!),
      ),
    ),
  ],
);
