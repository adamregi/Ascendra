import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../providers/create_task_provider.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  const CreateTaskPage({super.key});

  @override
  ConsumerState<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends ConsumerState<CreateTaskPage> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createTaskControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainer,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.x, color: AppColors.onSurfaceVariant),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Create Task Campaign',
          style: TextStyle(
            fontFamily: 'Newsreader',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.onSurfaceVariant,
              textStyle: const TextStyle(
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            child: const Text('Save Draft'),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderSubtle, height: 1),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.xl,
              bottom: 120, // Extra padding for sticky CTA
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Task Title Input
                  TextField(
                    controller: _titleController,
                    onChanged:
                        (val) => ref
                            .read(createTaskControllerProvider.notifier)
                            .updateTitle(val),
                    style: const TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Speak To 5 Qualified Prospects',
                      hintStyle: const TextStyle(color: AppColors.borderSubtle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        borderSide: const BorderSide(
                          color: AppColors.borderSubtle,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        borderSide: const BorderSide(
                          color: AppColors.borderSubtle,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg,
                        horizontal: AppSpacing.lg,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Task Type Bento Grid
                  const Text(
                    'Task Type',
                    style: TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTaskTypeGrid(state.taskType),
                  const SizedBox(height: AppSpacing.xxl),

                  // Proof Requirements
                  const Text(
                    'Proof Requirements',
                    style: TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildProofRequirements(state.proofRequirements),
                  const SizedBox(height: AppSpacing.xxl),

                  // Smart Assignment
                  const Text(
                    'Smart Assignment',
                    style: TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSmartAssignment(state.assignmentType),
                  const SizedBox(height: AppSpacing.xxl),

                  // AI Suggestion Card
                  _buildAiSuggestion(),
                ],
              ),
            ),
          ),

          // Sticky Bottom CTA
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildStickyCta(state.isSubmitting),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTypeGrid(String selectedType) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.5,
          children: [
            _buildTypeCard(
              'recruitment',
              'Recruitment',
              LucideIcons.users,
              selectedType,
            ),
            _buildTypeCard(
              'demo',
              'Product Demo',
              LucideIcons.box,
              selectedType,
            ),
            _buildTypeCard(
              'training',
              'Training',
              LucideIcons.graduationCap,
              selectedType,
            ),
            _buildTypeCard(
              'followup',
              'Follow Up',
              LucideIcons.messageSquare,
              selectedType,
            ),
            _buildTypeCard(
              'custom',
              'Custom',
              LucideIcons.settings,
              selectedType,
              colSpan: crossAxisCount == 2 ? 2 : 1,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeCard(
    String id,
    String label,
    IconData icon,
    String selectedType, {
    int colSpan = 1,
  }) {
    final isSelected = id == selectedType;
    final color =
        isSelected
            ? AppColors.onSecondaryContainer
            : AppColors.onSurfaceVariant;
    final bgColor =
        isSelected ? AppColors.secondaryContainer : AppColors.surfaceContainer;

    return InkWell(
      onTap:
          () => ref
              .read(createTaskControllerProvider.notifier)
              .selectTaskType(id),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderSubtle,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: AppSpacing.md),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Hanken Grotesk',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProofRequirements(Set<String> selected) {
    final options = ['Mobile Numbers', 'Contact Names', 'Screenshot', 'Photo'];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 600;
        final children = [
          // Checkboxes
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              children:
                  options.map((opt) {
                    final isChecked = selected.contains(opt);
                    return InkWell(
                      onTap:
                          () => ref
                              .read(createTaskControllerProvider.notifier)
                              .toggleProofRequirement(opt),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged:
                                  (_) => ref
                                      .read(
                                        createTaskControllerProvider.notifier,
                                      )
                                      .toggleProofRequirement(opt),
                              activeColor: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              opt,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          if (isDesktop) const SizedBox(width: AppSpacing.xl),
          // Live Preview
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Container(
              margin: EdgeInsets.only(top: isDesktop ? 0 : AppSpacing.lg),
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: AppColors.borderSubtle.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: -AppSpacing.xl,
                    top: -AppSpacing.xl,
                    bottom: -AppSpacing.xl,
                    child: Container(width: 4, color: AppColors.primary),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LIVE PREVIEW',
                        style: TextStyle(
                          fontFamily: 'Hanken Grotesk',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.borderSubtle,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Hanken Grotesk',
                            fontSize: 18,
                            color: AppColors.primary,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(text: 'Members must submit: '),
                            if (selected.isEmpty)
                              const TextSpan(
                                text: 'Nothing.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            else
                              TextSpan(
                                text: selected.join(', '),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ];

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
      },
    );
  }

  Widget _buildSmartAssignment(String selectedType) {
    return Column(
      children: [
        // Tabs
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            children: [
              _buildSegmentTab('segments', 'Dynamic Segments', selectedType),
              _buildSegmentTab('branches', 'Branches', selectedType),
              _buildSegmentTab('individuals', 'Individuals', selectedType),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Filter result box
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.filter,
                      color: AppColors.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                          children: [
                            TextSpan(text: 'Targeting condition: '),
                            TextSpan(
                              text: 'New Joiners',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '42 Members Selected',
                        style: TextStyle(
                          fontFamily: 'Newsreader',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.edit2, color: AppColors.primary),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentTab(String id, String label, String selected) {
    final isSelected = id == selected;
    return Expanded(
      child: InkWell(
        onTap:
            () => ref
                .read(createTaskControllerProvider.notifier)
                .selectAssignmentType(id),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ]
                    : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Hanken Grotesk',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color:
                    isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAiSuggestion() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceContainerLow,
            AppColors.secondaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.secondaryContainer.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.sparkles, color: Color(0xFFF59E0B)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI SUGGESTION',
                  style: TextStyle(
                    fontFamily: 'Hanken Grotesk',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Hanken Grotesk',
                      fontSize: 16,
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'For better completion rates, consider allowing ',
                      ),
                      TextSpan(
                        text: 'photo proof',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: ' instead of PDF uploads.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyCta(bool isSubmitting) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Center(
        child: SizedBox(
          width: 400,
          height: 56,
          child: ElevatedButton(
            onPressed:
                isSubmitting
                    ? null
                    : () async {
                      await ref
                          .read(createTaskControllerProvider.notifier)
                          .submit();
                      if (context.mounted) context.pop();
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            child:
                isSubmitting
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.onPrimary,
                        strokeWidth: 2,
                      ),
                    )
                    : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Task Campaign',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(LucideIcons.rocket, size: 18),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
