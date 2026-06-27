import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/badges.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/loading_widgets.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/tiles.dart';
import '../../../../shared/widgets/dialogs.dart';

class ComponentGalleryPage extends StatelessWidget {
  const ComponentGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Component Gallery')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const SectionHeader(title: 'Buttons'),
          AppButton(label: 'Primary Button', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Secondary Button',
            type: AppButtonType.secondary,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Outline Button',
            type: AppButtonType.outline,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Loading Button', isLoading: true, onPressed: () {}),

          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'Inputs'),
          const AppTextField(
            label: 'Standard TextField',
            hint: 'Type something...',
          ),
          const SizedBox(height: AppSpacing.md),
          const AppPasswordField(),
          const SizedBox(height: AppSpacing.md),
          const AppSearchField(),

          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'Badges & Chips'),
          const Wrap(
            spacing: AppSpacing.sm,
            children: [
              StatusBadge(label: 'Active'),
              RiskBadge(riskLevel: 'high'),
              RiskBadge(riskLevel: 'medium'),
              MetricChip(label: '85%', icon: Icons.trending_up),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'Cards & Tiles'),
          const StatCard(title: 'Total Revenue', value: '\$1.2M', trend: '12%'),
          const SizedBox(height: AppSpacing.md),
          const ListTileCard(
            title: 'John Doe',
            subtitle: 'Regional Manager',
            leading: AppAvatar(name: 'John Doe'),
          ),
          const SizedBox(height: AppSpacing.md),
          const AppCard(
            child: InfoTile(
              label: 'Last Synced',
              value: '2 mins ago',
              icon: Icons.sync,
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'States & Loaders'),
          const LoadingCard(height: 100),
          const SizedBox(height: AppSpacing.md),
          const SkeletonLoader(width: double.infinity, height: 60),
          const SizedBox(height: AppSpacing.md),
          const ErrorCard(message: 'Failed to load data'),
          const SizedBox(height: AppSpacing.md),
          const AppCard(
            child: EmptyState(
              title: 'No tasks found',
              message: 'You have caught up with everything.',
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'Dialogs'),
          AppButton(
            label: 'Show Confirmation',
            type: AppButtonType.outline,
            onPressed:
                () => Dialogs.showConfirmation(
                  context: context,
                  title: 'Delete Item',
                  message: 'Are you sure?',
                  isDestructive: true,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
