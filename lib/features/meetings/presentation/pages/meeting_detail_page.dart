import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/meeting_detail_provider.dart';
import '../widgets/meeting_header_card.dart';
import '../widgets/meeting_participants_section.dart';
import '../widgets/meeting_agenda_section.dart';
import '../widgets/attendance_summary_card.dart';
import '../widgets/recording_status_card.dart';
import '../widgets/meeting_action_bar.dart';
import '../../domain/entities/attendance_status.dart';
import '../../../../core/constants/app_radius.dart';

class MeetingDetailPage extends ConsumerWidget {
  final String meetingId;

  const MeetingDetailPage({super.key, required this.meetingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingDetailAsync = ref.watch(meetingDetailProvider(meetingId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'MEETING DETAIL',
          style: AppTypography.labelMd.copyWith(
            letterSpacing: 2.0,
            color: AppColors.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: meetingDetailAsync.when(
        data: (viewModel) {
          final meeting = viewModel.meeting;

          return Stack(
            children: [
              // Scrollable Content
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.lg,
                      120, // Padding for bottom action bar
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Hero header
                        MeetingHeaderCard(
                          meeting: meeting,
                          expectedAttendees:
                              meeting.maxParticipants ??
                              viewModel.attendances.length,
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Logistics (Date, Time, Timezone) - Could be extracted to its own section widget too
                        _buildLogisticsSection(meeting),

                        const SizedBox(height: AppSpacing.xl),

                        // Participants (Readiness + Guest list)
                        MeetingParticipantsSection(
                          totalInvites:
                              meeting.maxParticipants ??
                              viewModel.attendances.length,
                          confirmed:
                              viewModel
                                  .attendances
                                  .length, // Simplified logic for demo
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Attendance Summary (Only if started/completed)
                        if (meeting.startedAt != null) ...[
                          AttendanceSummaryCard(
                            registered: viewModel.attendances.length,
                            joined:
                                viewModel.attendances
                                    .where(
                                      (a) =>
                                          a.attendanceStatus ==
                                              AttendanceStatus.attended ||
                                          a.attendanceStatus ==
                                              AttendanceStatus.partial,
                                    )
                                    .length,
                            absent:
                                viewModel.attendances
                                    .where(
                                      (a) =>
                                          a.attendanceStatus ==
                                          AttendanceStatus.absent,
                                    )
                                    .length,
                            attendancePercentage:
                                viewModel.attendances.isEmpty
                                    ? 0
                                    : (viewModel.attendances
                                                .where(
                                                  (a) =>
                                                      a.attendanceStatus ==
                                                          AttendanceStatus
                                                              .attended ||
                                                      a.attendanceStatus ==
                                                          AttendanceStatus
                                                              .partial,
                                                )
                                                .length /
                                            viewModel.attendances.length) *
                                        100,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                        ],

                        // Recording Status
                        RecordingStatusCard(
                          status:
                              meeting.recordingUrl != null
                                  ? RecordingStatus.ready
                                  : (meeting.recordingEnabled
                                      ? RecordingStatus.processing
                                      : RecordingStatus.none),
                          onViewRecording:
                              () => context.push('/meetings/replay/$meetingId'),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Agenda
                        MeetingAgendaSection(agenda: meeting.agenda),
                      ]),
                    ),
                  ),
                ],
              ),

              // Sticky Action Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MeetingActionBar(
                  status: meeting.meetingStatus,
                  permissions: const MeetingPermissions(
                    isLeader: true,
                    canEdit: true,
                  ), // Mock permissions for now
                  onShare: () {},
                  onEdit: () {},
                  onJoin: () => context.push('/meetings/live/$meetingId'),
                ),
              ),
            ],
          );
        },
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        error:
            (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 48,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Failed to load meeting details',
                    style: AppTypography.headlineSm,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    err.toString(),
                    style: AppTypography.body2.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildLogisticsSection(meeting) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Logistics',
            style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
          ),
          const Divider(color: AppColors.borderSubtle, height: AppSpacing.xl),
          _buildLogisticItem(
            Icons.event_outlined,
            'Date',
            '${meeting.scheduledAt.day}/${meeting.scheduledAt.month}/${meeting.scheduledAt.year}',
          ),
          const SizedBox(height: AppSpacing.md),
          _buildLogisticItem(
            Icons.schedule_outlined,
            'Time',
            '${meeting.scheduledAt.hour}:${meeting.scheduledAt.minute.toString().padLeft(2, '0')}',
          ),
          const SizedBox(height: AppSpacing.md),
          _buildLogisticItem(Icons.public_outlined, 'Timezone', 'Local Time'),
        ],
      ),
    );
  }

  Widget _buildLogisticItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.borderSubtle, size: 24),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: AppTypography.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
