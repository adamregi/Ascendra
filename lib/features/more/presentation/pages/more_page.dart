import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../features/auth/providers/auth_controller.dart';

class QuickAction {
  final String title;
  final IconData icon;
  final String route;
  
  const QuickAction({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  static const _quickActions = [
    QuickAction(
      title: 'Schedule Meeting',
      icon: LucideIcons.calendarPlus,
      route: '/meetings/schedule',
    ),
    QuickAction(
      title: 'Create Task',
      icon: LucideIcons.checkSquare,
      route: '/tasks/create',
    ),
    // Members creation route doesn't exist yet, but leaving as requested
    QuickAction(
      title: 'Add Member',
      icon: LucideIcons.userPlus,
      route: '/members/add', 
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More', style: AppTypography.h3),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: _buildSearchBar(context),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Quick Actions'),
          ),
          SliverToBoxAdapter(
            child: _buildQuickActions(context),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Leadership'),
          ),
          SliverToBoxAdapter(
            child: _buildMenuGroup(
              context,
              children: [
                _buildMenuItem(
                  context: context,
                  icon: LucideIcons.users,
                  title: 'Members',
                  route: '/members',
                ),
                // Network hidden behind feature flag / commented out
                // _buildMenuItem(context, LucideIcons.gitCommit, 'Network', '/network'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Insights'),
          ),
          SliverToBoxAdapter(
            child: _buildMenuGroup(
              context,
              children: [
                _buildMenuItem(
                  context: context,
                  icon: LucideIcons.sparkles,
                  title: 'AI Assistant',
                  route: '/ai',
                ),
                // Analytics hidden behind feature flag / commented out
                // _buildMenuItem(context, LucideIcons.barChart2, 'Analytics', '/analytics'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Account'),
          ),
          SliverToBoxAdapter(
            child: _buildMenuGroup(
              context,
              children: [
                _buildMenuItem(
                  context: context,
                  icon: LucideIcons.bell,
                  title: 'Notifications',
                  route: '/alerts',
                ),
                _buildMenuItem(
                  context: context,
                  icon: LucideIcons.settings,
                  title: 'Settings',
                  route: '/settings',
                ),
                // Profile hidden behind feature flag / commented out
                // _buildMenuItem(context, LucideIcons.user, 'Profile', '/profile'),
              ],
            ),
          ),
          if (kDebugMode) ...[
            SliverToBoxAdapter(
              child: _buildSectionHeader('Developer (Debug)'),
            ),
            SliverToBoxAdapter(
              child: _buildMenuGroup(
                context,
                children: [
                  _buildMenuItem(
                    context: context,
                    icon: LucideIcons.terminal,
                    title: 'QA Tools',
                    route: '/dev/qa',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: LucideIcons.layoutTemplate,
                    title: 'Component Gallery',
                    route: '/dev/components',
                  ),
                ],
              ),
            ),
          ],
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorContainer,
                  foregroundColor: AppColors.error,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                icon: const Icon(LucideIcons.logOut, size: 20),
                label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 48)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search features...',
          hintStyle: TextStyle(color: AppColors.textHint),
          prefixIcon: Icon(LucideIcons.search, color: AppColors.textHint),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title,
        style: AppTypography.subtitle1.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _quickActions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final action = _quickActions[index];
          return _buildQuickActionCard(context, action);
        },
      ),
    );
  }

  Widget _buildQuickActionCard(BuildContext context, QuickAction action) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: () {
          // If the route is missing, it will just log or handle nicely
          if (action.route.isNotEmpty) {
             context.push(action.route);
          }
        },
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          width: 110,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(action.icon, color: AppColors.primary, size: 24),
              const SizedBox(height: 8),
              Text(
                action.title,
                textAlign: TextAlign.center,
                style: AppTypography.body2.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGroup(BuildContext context, {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 24),
      title: Text(title, style: AppTypography.body1),
      trailing: const Icon(LucideIcons.chevronRight, size: 20, color: AppColors.textHint),
      onTap: () => context.go(route),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}
