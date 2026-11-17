import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/goals_repository.dart';
import '../domain/goal.dart';

part 'goals_providers.g.dart';

/// Every goal, oldest first.
@riverpod
Stream<List<Goal>> goals(Ref ref) =>
    ref.watch(goalsRepositoryProvider).watchGoals();
