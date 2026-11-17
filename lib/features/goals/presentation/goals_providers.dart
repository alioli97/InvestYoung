import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/goals_repository.dart';
import '../../investments/presentation/investments_providers.dart';
import '../domain/goal.dart';
import '../domain/goal_progress.dart';
import '../domain/goal_type.dart';

part 'goals_providers.g.dart';

/// Every goal, oldest first.
@riverpod
Stream<List<Goal>> goals(Ref ref) =>
    ref.watch(goalsRepositoryProvider).watchGoals();

/// Progress of every goal, updated when goals, assets or transactions change.
@riverpod
Future<List<GoalProgress>> goalProgressList(Ref ref) async =>
    GoalProgress.compute(
      await ref.watch(goalsProvider.future),
      await ref.watch(assetSummariesProvider.future),
    );

/// Progress of the emergency goal, or `null` if there is none.
@riverpod
Future<GoalProgress?> emergencyProgress(Ref ref) async => (await ref.watch(
  goalProgressListProvider.future,
)).where((p) => p.goal.type == GoalType.emergency).firstOrNull;
