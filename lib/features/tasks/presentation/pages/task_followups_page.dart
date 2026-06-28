import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../providers/task_followups_provider.dart';
import '../widgets/followups/followup_composer.dart';

class TaskFollowupsPage extends ConsumerWidget {
  final String taskId;

  const TaskFollowupsPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followupsAsync = ref.watch(taskFollowupsProvider(taskId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: AppColors.onSurfaceVariant,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Task Follow-ups',
          style: TextStyle(
            fontFamily: 'Newsreader',
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderSubtle, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: followupsAsync.when(
              data: (followups) {
                if (followups.isEmpty) {
                  return const Center(
                    child: Text(
                      'No follow-ups yet.\nStart a conversation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: followups.length,
                  itemBuilder: (context, index) {
                    // For now this is just a placeholder until we have real data
                    return const SizedBox.shrink();
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          FollowUpComposer(
            onSubmit: (text) {
              // Send message logic
            },
          ),
        ],
      ),
    );
  }
}
