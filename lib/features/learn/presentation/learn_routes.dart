import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import 'learn_screen.dart';
import 'lesson_screen.dart';

/// Routes of the Learn tab.
final learnRoute = GoRoute(
  path: Routes.learn,
  builder: (context, state) => const LearnScreen(),
  routes: [
    GoRoute(
      path: 'lesson/:lessonId',
      builder: (context, state) =>
          LessonScreen(lessonId: state.pathParameters['lessonId']!),
    ),
  ],
);
