import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../domain/investment_enums.dart';
import 'asset_detail_screen.dart';
import 'asset_form_screen.dart';
import 'category_assets_screen.dart';
import 'investments_screen.dart';
import 'transaction_form_screen.dart';

AssetCategory? _category(GoRouterState state) {
  final value = state.pathParameters['category'];
  for (final category in AssetCategory.values) {
    if (category.dbValue == value) return category;
  }
  return null;
}

int? _id(GoRouterState state, String name) =>
    int.tryParse(state.pathParameters[name] ?? '');

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
      path: 'asset/:assetId',
      redirect: (context, state) =>
          _id(state, 'assetId') == null ? Routes.investments : null,
      builder: (context, state) =>
          AssetDetailScreen(assetId: _id(state, 'assetId')!),
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) =>
              AssetFormScreen.edit(assetId: _id(state, 'assetId')!),
        ),
        GoRoute(
          path: 'transaction/new',
          builder: (context, state) =>
              TransactionFormScreen(assetId: _id(state, 'assetId')!),
        ),
        GoRoute(
          path: 'transaction/:transactionId',
          redirect: (context, state) => _id(state, 'transactionId') == null
              ? Routes.asset(_id(state, 'assetId')!)
              : null,
          builder: (context, state) => TransactionFormScreen(
            assetId: _id(state, 'assetId')!,
            transactionId: _id(state, 'transactionId'),
          ),
        ),
      ],
    ),
  ],
);
