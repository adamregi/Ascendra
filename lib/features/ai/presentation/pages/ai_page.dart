import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ascendra', style: AppTypography.displayLgMobile),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {},
            color: AppColors.onSurfaceVariant,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildHero(),
                    const SizedBox(height: 24),
                    _buildDashboardCards(),
                    const SizedBox(height: 24),
                    _buildModesControl(),
                    const SizedBox(height: 24),
                    _buildInsightFeed(),
                    const SizedBox(height: 24),
                    _buildChatInterface(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, Vignesh.',
          style: AppTypography.displayLgMobile.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            const Text('Team compliance is 91%', style: AppTypography.bodyLg),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('•', style: TextStyle(color: AppColors.outlineVariant)),
            ),
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            const Text('2 members require attention', style: TextStyle(color: AppColors.error, fontSize: 18, fontFamily: 'Hanken Grotesk')),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboardCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: [
        _buildGlassCard(
          title: 'Health',
          icon: LucideIcons.activity,
          value: 'Strong',
          valueColor: AppColors.primary,
        ),
        _buildGlassCard(
          title: 'Compliance',
          icon: LucideIcons.badgeCheck,
          value: '91%',
          valueColor: AppColors.primary,
        ),
        _buildGlassCard(
          title: 'Risk',
          icon: LucideIcons.alertTriangle,
          value: 'Elevated',
          valueColor: AppColors.error,
          borderColor: AppColors.error,
        ),
        _buildGlassCard(
          title: 'Growth',
          icon: LucideIcons.trendingUp,
          value: '+4.2%',
          valueColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required String value,
    required Color valueColor,
    Color? borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: borderColor ?? AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(title.toUpperCase(), style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: 8),
              Text(value, style: AppTypography.headlineSm.copyWith(color: valueColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModesControl() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        children: [
          Expanded(child: _buildModeButton('Coach', true)),
          Expanded(child: _buildModeButton('Analyst', false)),
          Expanded(child: _buildModeButton('Trainer', false)),
          Expanded(child: _buildModeButton('Strategist', false)),
        ],
      ),
    );
  }

  Widget _buildModeButton(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTypography.labelMd.copyWith(
          color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildInsightFeed() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryFixed.withOpacity(0.5),
        border: Border.all(color: AppColors.secondaryFixedDim),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.lightbulb, color: AppColors.onSecondary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STRATEGIC INSIGHT',
                  style: AppTypography.labelSm.copyWith(color: AppColors.onSecondaryContainer),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Branch B task completion has decreased by 12% over the last two weeks. This correlates directly with the recent management restructuring.',
                  style: AppTypography.bodyMd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInterface() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          children: [
              // Chat Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.5),
                  border: const Border(bottom: BorderSide(color: AppColors.surfaceVariant)),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.lock, size: 14, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Text('PRIVATE TO YOU', style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ),
              // Chat Messages
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildAiMessage(),
                    const SizedBox(height: 24),
                    _buildUserMessage(),
                    const SizedBox(height: 32),
                    _buildSuggestedPrompts(),
                  ],
                ),
              ),
              // Input Area
              _buildChatInput(),
            ],
          ),
        ),
    );
  }

  Widget _buildAiMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.brain, color: AppColors.onPrimary, size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                top: BorderSide(color: AppColors.surfaceVariant),
                bottom: BorderSide(color: AppColors.surfaceVariant),
                left: BorderSide(color: AppColors.surfaceVariant),
                right: BorderSide(color: AppColors.surfaceVariant),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "I've analyzed the recent performance reports. The drop in compliance seems localized. Would you like me to identify the specific members at risk or draft a brief for the regional manager?",
                  style: AppTypography.bodyMd,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildActionChip(LucideIcons.userCheck, 'Identify members'),
                    const SizedBox(width: 8),
                    _buildActionChip(LucideIcons.fileEdit, 'Draft brief'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 32), // Spacer for 85% width limit
      ],
    );
  }

  Widget _buildActionChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.onSurface),
          const SizedBox(width: 4),
          Text(label, style: AppTypography.labelSm.copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildUserMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 32), // Spacer for 85% width limit
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              "Show me the members at risk first.",
              style: AppTypography.bodyMd.copyWith(color: AppColors.onPrimary),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.user, color: AppColors.onSecondary, size: 18),
        ),
      ],
    );
  }

  Widget _buildSuggestedPrompts() {
    return Column(
      children: [
        Text('SUGGESTED PROMPTS', style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildPromptChip('Why did compliance drop?'),
            _buildPromptChip('Create a recovery plan'),
          ],
        ),
      ],
    );
  }

  Widget _buildPromptChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(text, style: AppTypography.labelSm.copyWith(color: AppColors.onSurface)),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        border: const Border(top: BorderSide(color: AppColors.surfaceVariant)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Ask your executive coach...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.arrowUp, color: AppColors.onPrimary, size: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondaryFixedDim),
                ),
                child: const Icon(LucideIcons.mic, color: AppColors.onSecondaryContainer),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInputShortcut(LucideIcons.checkSquare, 'Create Task'),
              const SizedBox(width: 16),
              _buildInputShortcut(LucideIcons.calendar, 'Schedule Meeting'),
              const SizedBox(width: 16),
              _buildInputShortcut(LucideIcons.bell, 'Send Reminder'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputShortcut(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
      ],
    );
  }
}
