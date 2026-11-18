import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/goals/presentation/goals_routes.dart';
import '../../features/investments/presentation/investments_routes.dart';
import '../../features/learn/presentation/learn_routes.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/onboarding_status_provider.dart';
import '../../features/onboarding/presentation/retake_onboarding_screen.dart';
import '../../features/profile/presentation/profile_routes.dart';
import 'app_shell.dart';
import 'routes.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Re-evaluates redirects whenever the onboarding status changes.
  final refresh = ValueNotifier<bool>(ref.read(onboardingStatusProvider));
  ref.listen(onboardingStatusProvider, (_, next) => refresh.value = next);
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    refreshListenable: refresh,
    redirect: (context, state) =>
        onboardingRedirect(refresh.value, state.matchedLocation),
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.retakeOnboarding,
        builder: (context, state) => const RetakeOnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          _branch(Routes.home, const DashboardScreen()),
          StatefulShellBranch(routes: [goalsRoute]),
          StatefulShellBranch(routes: [investmentsRoute]),
          StatefulShellBranch(routes: [learnRoute]),
          StatefulShellBranch(routes: [profileRoute]),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (context, state) => screen)],
  );
}

/// Sends users to onboarding until it is completed, and away from it afterwards.
@visibleForTesting
String? onboardingRedirect(bool onboardingCompleted, String location) {
  final inOnboarding = location.startsWith(Routes.onboarding);
  if (!onboardingCompleted) return inOnboarding ? null : Routes.onboarding;
  return inOnboarding ? Routes.home : null;
}
