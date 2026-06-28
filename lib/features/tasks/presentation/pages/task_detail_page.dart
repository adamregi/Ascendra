import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/responsive/responsive_padding.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../providers/tasks_providers.dart';
import '../widgets/detail/task_detail_hero_card.dart';
import '../widgets/detail/task_stats_row.dart';
import '../widgets/detail/task_funnel.dart';
import '../widgets/detail/task_activity_timeline.dart';
import '../widgets/detail/proof_review_center.dart';
import '../widgets/task_proof_submission_widget.dart';
import '../widgets/detail/task_danger_zone.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  Future<void> _refresh() async {
    ref.invalidate(taskDetailProvider(widget.taskId));
    ref.invalidate(taskAssignmentsProvider(widget.taskId));
    ref.invalidate(taskAssignmentStatsProvider(widget.taskId));
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskDetailProvider(widget.taskId));
    final assignmentsAsync = ref.watch(taskAssignmentsProvider(widget.taskId));
    final statsAsync = ref.watch(taskAssignmentStatsProvider(widget.taskId));

    final isLoading =
        taskAsync.isLoading ||
        statsAsync.isLoading ||
        assignmentsAsync.isLoading;
    final hasError =
        taskAsync.hasError || statsAsync.hasError || assignmentsAsync.hasError;

    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: Center(
          child: ErrorCard(
            message: 'Failed to load task details',
            onRetry: _refresh,
          ),
        ),
      );
    }

    final task = taskAsync.value;
    if (task == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: const Center(child: Text('Task not found')),
      );
    }

    final stats = statsAsync.value ?? {};
    final assignments = assignmentsAsync.value ?? [];

    return BasePage(
      onRefresh: _refresh,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            backgroundColor: AppColors.surface.withValues(alpha: 0.9),
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                LucideIcons.arrowLeft,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              task.title,
              style: const TextStyle(
                fontFamily: 'Newsreader',
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  LucideIcons.edit2,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {
                  // Navigate to edit
                },
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ),

          // ── Body ──
          SliverToBoxAdapter(
            child: ResponsivePadding(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TaskDetailHeroCard(task: task, stats: stats),
                    const SizedBox(height: AppSpacing.lg),
                    TaskStatsRow(stats: stats),
                    const SizedBox(height: AppSpacing.lg),

                    // Desktop two-column layout for Funnel & Leaderboard/Review
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 768) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: TaskFunnel(stats: stats)),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(
                                child: Column(
                                  children: [
                                    ProofReviewCenter(assignments: assignments),
                                    const SizedBox(height: AppSpacing.lg),
                                    TaskProofSubmissionWidget(taskId: task.id),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Mobile layout
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TaskFunnel(stats: stats),
                              const SizedBox(height: AppSpacing.lg),
                              ProofReviewCenter(assignments: assignments),
                              const SizedBox(height: AppSpacing.lg),
                              TaskProofSubmissionWidget(taskId: task.id),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: AppSpacing.lg),
                    const TaskActivityTimeline(),
                    const SizedBox(height: AppSpacing.xl),
                    const TaskDangerZone(),
                    const SizedBox(height: 80), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
