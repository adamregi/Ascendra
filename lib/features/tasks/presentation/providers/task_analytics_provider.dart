import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_analytics_provider.g.dart';

class TaskAnalytics {
  final double completionPercent;
  final int overdueTasks;
  final String avgCompletionTime;
  final double complianceScore;
  final int pendingProofs;
  final int todaysTasks;
  final List<double> weeklyTrend; // Example: completion % for last 7 days

  const TaskAnalytics({
    this.completionPercent = 0,
    this.overdueTasks = 0,
    this.avgCompletionTime = '0h',
    this.complianceScore = 0,
    this.pendingProofs = 0,
    this.todaysTasks = 0,
    this.weeklyTrend = const [],
  });
}

@riverpod
Future<TaskAnalytics> taskAnalytics(TaskAnalyticsRef ref) async {
  // Simulate fetching from mv_task_analytics RPC
  await Future.delayed(const Duration(milliseconds: 600));

  return const TaskAnalytics(
    completionPercent: 82.5,
    overdueTasks: 14,
    avgCompletionTime: '4.2h',
    complianceScore: 94.1,
    pendingProofs: 28,
    todaysTasks: 45,
    weeklyTrend: [75, 78, 80, 85, 82, 88, 92],
  );
}
