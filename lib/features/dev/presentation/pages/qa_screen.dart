import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class QaScreen extends StatelessWidget {
  const QaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('QA Tools', style: AppTypography.h3),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildQaSection(
            'System & Environment',
            [
              _buildQaItem('Architecture Info', LucideIcons.cpu),
              _buildQaItem('Network Status', LucideIcons.wifi),
              _buildQaItem('Supabase Connection', LucideIcons.database),
            ],
          ),
          const SizedBox(height: 24),
          _buildQaSection(
            'State & Caching',
            [
              _buildQaItem('Clear Image Cache', LucideIcons.imageMinus),
              _buildQaItem('Clear Secure Storage', LucideIcons.lock),
              _buildQaItem('Riverpod Inspector', LucideIcons.glasses),
            ],
          ),
          const SizedBox(height: 24),
          _buildQaSection(
            'UI & Theming',
            [
              _buildQaItem('Theme Debugger', LucideIcons.palette),
              _buildQaItem('Font Scaling', LucideIcons.type),
            ],
          ),
          const SizedBox(height: 24),
          _buildQaSection(
            'Performance',
            [
              _buildQaItem('Navigation Logs', LucideIcons.navigation),
              _buildQaItem('Memory Usage', LucideIcons.activity),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQaSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.labelMd.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildQaItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.bodyMd),
      trailing: const Icon(LucideIcons.chevronRight, size: 18, color: AppColors.textHint),
      onTap: () {
        // Implement QA actions here
      },
    );
  }
}
