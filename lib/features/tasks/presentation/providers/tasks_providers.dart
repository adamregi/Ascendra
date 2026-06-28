import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/extensions/ref_extensions.dart';
import '../../../profile/providers/profile_provider.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/task_assignment.dart';
import '../../domain/repositories/task_repository.dart';

part 'tasks_providers.g.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(Supabase.instance.client);
}

// ---------------------------------------------------------------------------
// Data providers (with 5-min TTL)
// ---------------------------------------------------------------------------

@riverpod
Future<List<Task>> companyTasks(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  final companyId = await ref.watch(companyIdProvider.future);
  if (companyId == null) return [];
  return ref.watch(taskRepositoryProvider).getTasks(companyId: companyId);
}

// ---------------------------------------------------------------------------
// Dashboard filter state
// ---------------------------------------------------------------------------

enum TaskDashboardFilter { all, open, inProgress, completed, overdue }

@riverpod
class SelectedTaskFilter extends _$SelectedTaskFilter {
  @override
  TaskDashboardFilter build() => TaskDashboardFilter.all;

  void select(TaskDashboardFilter filter) => state = filter;
}

// ---------------------------------------------------------------------------
// Search
// ---------------------------------------------------------------------------

@riverpod
class TaskSearchQuery extends _$TaskSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

// ---------------------------------------------------------------------------
// Filtered tasks
// ---------------------------------------------------------------------------

@riverpod
Future<List<Task>> filteredTasks(Ref ref) async {
  final filter = ref.watch(selectedTaskFilterProvider);
  final tasks = await ref.watch(companyTasksProvider.future);

  switch (filter) {
    case TaskDashboardFilter.all:
      return tasks;
    case TaskDashboardFilter.open:
      return tasks
          .where((t) => t.status == 'open' || t.status == 'draft')
          .toList();
    case TaskDashboardFilter.inProgress:
      return tasks
          .where((t) => t.status == 'in_progress' || t.status == 'active')
          .toList();
    case TaskDashboardFilter.completed:
      return tasks.where((t) => t.status == 'completed').toList();
    case TaskDashboardFilter.overdue:
      return tasks.where((t) {
        if (t.dueDate == null) return false;
        return t.status != 'completed' &&
            t.status != 'cancelled' &&
            DateTime.now().isAfter(t.dueDate!);
      }).toList();
  }
}

// ---------------------------------------------------------------------------
// Searched tasks
// ---------------------------------------------------------------------------

@riverpod
Future<List<Task>> searchedTasks(Ref ref) async {
  final query = ref.watch(taskSearchQueryProvider).toLowerCase().trim();
  final tasks = await ref.watch(filteredTasksProvider.future);

  if (query.isEmpty) return tasks;

  return tasks.where((t) {
    return t.title.toLowerCase().contains(query) ||
        (t.description?.toLowerCase().contains(query) ?? false) ||
        t.tags.any((tag) => tag.toLowerCase().contains(query));
  }).toList();
}

// ---------------------------------------------------------------------------
// Dashboard summary (computed from tasks)
// ---------------------------------------------------------------------------

class TaskDashboardSummary {
  final int totalCount;
  final int openCount;
  final int inProgressCount;
  final int completedCount;
  final int overdueCount;
  final double completionPercent;

  const TaskDashboardSummary({
    this.totalCount = 0,
    this.openCount = 0,
    this.inProgressCount = 0,
    this.completedCount = 0,
    this.overdueCount = 0,
    this.completionPercent = 0,
  });
}

@riverpod
Future<TaskDashboardSummary> taskDashboardSummary(Ref ref) async {
  final tasks = await ref.watch(companyTasksProvider.future);
  if (tasks.isEmpty) return const TaskDashboardSummary();

  final now = DateTime.now();
  int open = 0;
  int inProg = 0;
  int completed = 0;
  int overdue = 0;

  for (final t in tasks) {
    final isOverdue =
        t.dueDate != null &&
        now.isAfter(t.dueDate!) &&
        t.status != 'completed' &&
        t.status != 'cancelled';

    if (isOverdue) {
      overdue++;
    } else if (t.status == 'completed') {
      completed++;
    } else if (t.status == 'in_progress' || t.status == 'active') {
      inProg++;
    } else if (t.status == 'open' ||
        t.status == 'draft' ||
        t.status == 'assigned') {
      open++;
    }
  }

  final total = tasks.where((t) => t.status != 'cancelled').length;
  final pct = total > 0 ? (completed / total * 100) : 0.0;

  return TaskDashboardSummary(
    totalCount: total,
    openCount: open,
    inProgressCount: inProg,
    completedCount: completed,
    overdueCount: overdue,
    completionPercent: pct,
  );
}

// ---------------------------------------------------------------------------
// Task Details and Assignments
// ---------------------------------------------------------------------------

@riverpod
Future<Task?> taskDetail(Ref ref, String taskId) async {
  final tasks = await ref.watch(companyTasksProvider.future);
  try {
    return tasks.firstWhere((t) => t.id == taskId);
  } catch (_) {
    return null;
  }
}

@riverpod
Future<List<TaskAssignment>> taskAssignments(Ref ref, String taskId) async {
  return ref.watch(taskRepositoryProvider).getAssignments(taskId: taskId);
}

@riverpod
Future<Map<String, int>> taskAssignmentStats(Ref ref, String taskId) async {
  final assignments = await ref.watch(taskAssignmentsProvider(taskId).future);

  int assigned = 0;
  int inProgress = 0;
  int completed = 0;
  int overdue = 0;
  int needsReview = 0;

  for (final a in assignments) {
    assigned++;
    if (a.status.name == 'inProgress') inProgress++;
    if (a.status.name == 'approved' || a.status.name == 'completed')
      completed++;
    if (a.status.name == 'overdue') overdue++;
    if (a.status.name == 'submitted') needsReview++;
  }

  return {
    'assigned': assigned,
    'inProgress': inProgress,
    'completed': completed,
    'overdue': overdue,
    'needsReview': needsReview,
  };
}
