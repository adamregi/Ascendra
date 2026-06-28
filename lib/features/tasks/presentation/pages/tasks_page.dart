import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/responsive/responsive_padding.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/badges.dart';
import '../../../profile/providers/profile_provider.dart';
import '../providers/tasks_providers.dart';
import '../widgets/task_execution_health_card.dart';
import '../widgets/task_status_chips_row.dart';
import '../widgets/task_filter_bar.dart';
import '../widgets/task_list_card.dart';
import '../widgets/task_empty_state.dart';
import '../widgets/task_analytics_dashboard.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage>
    with WidgetsBindingObserver {
  DateTime? _lastRefresh;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshWithThrottling();
    }
  }

  void _refreshWithThrottling() {
    final now = DateTime.now();
    if (_lastRefresh == null || now.difference(_lastRefresh!).inSeconds > 60) {
      _lastRefresh = now;
      _invalidateAll();
    }
  }

  void _invalidateAll() {
    ref.invalidate(companyTasksProvider);
  }

  void _onSearchChanged(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(taskSearchQueryProvider.notifier).update(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(taskDashboardSummaryProvider);
    final tasksAsync = ref.watch(searchedTasksProvider);
    final filter = ref.watch(selectedTaskFilterProvider);
    final permissionsAsync = ref.watch(permissionsProvider);
    final canCreate =
        permissionsAsync.value == 'leader' || permissionsAsync.value == 'admin';

    return BasePage(
      floatingActionButton:
          canCreate
              ? FloatingActionButton.extended(
                onPressed: () => context.push('/tasks/create'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                icon: const Icon(LucideIcons.plus, size: 20),
                label: const Text(
                  'New Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              )
              : null,
      body: RefreshIndicator(
        onRefresh: () async {
          _lastRefresh = DateTime.now();
          _invalidateAll();
        },
        child: ResponsivePadding(
          child: CustomScrollView(
            slivers: [
              // ── Page Header ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.lg,
                    bottom: AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formattedDate(),
                        style: const TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurfaceVariant,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Tasks Command Center',
                        style: TextStyle(
                          fontFamily: 'Newsreader',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Analytics Dashboard ──
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md),
                  child: TaskAnalyticsDashboard(),
                ),
              ),

              // ── Smart Status Chips Row ──
              SliverToBoxAdapter(
                child: summaryAsync.when(
                  data:
                      (summary) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: TaskStatusChipsRow(summary: summary),
                      ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),

              // ── Search Bar ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      prefixIcon: const Icon(LucideIcons.search, size: 20),
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Filter Bar ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: TaskFilterBar(
                    selected: filter,
                    onSelected: (newFilter) {
                      ref
                          .read(selectedTaskFilterProvider.notifier)
                          .select(newFilter);
                    },
                  ),
                ),
              ),

              // ── Task List ──
              tasksAsync.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: TaskEmptyState(filter: filter),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final task = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: TaskListCard(
                          task: task,
                          onTap: () => context.push('/tasks/${task.id}'),
                        ),
                      );
                    }, childCount: tasks.length),
                  );
                },
                loading:
                    () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                error:
                    (e, st) => SliverFillRemaining(
                      child: ErrorCard(
                        message: 'Failed to load tasks',
                        onRetry: _invalidateAll,
                      ),
                    ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 80), // FAB padding
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day.toString().padLeft(2, '0')}'
        .toUpperCase();
  }
}
