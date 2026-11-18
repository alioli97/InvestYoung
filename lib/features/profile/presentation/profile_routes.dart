import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import 'legal_notice_screen.dart';
import 'profile_screen.dart';

/// Routes of the Profile tab.
final profileRoute = GoRoute(
  path: Routes.profile,
  builder: (context, state) => const ProfileScreen(),
  routes: [
    GoRoute(
      path: 'legal',
      builder: (context, state) => const LegalNoticeScreen(),
    ),
  ],
);
