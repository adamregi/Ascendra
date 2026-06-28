import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/extensions/ref_extensions.dart';
import '../../../profile/providers/profile_provider.dart';
import '../../../profile/data/user_repository.dart';
import '../../data/models/meeting_dashboard_summary.dart';
import '../../data/repositories/meeting_repository_impl.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/meeting_status_filter.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../../domain/repositories/meeting_replay_repository.dart';
import '../../data/repositories/meeting_replay_repository_impl.dart';

part 'meetings_providers.g.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

@riverpod
MeetingRepository meetingRepository(Ref ref) {
  return MeetingRepositoryImpl(Supabase.instance.client);
}

@riverpod
MeetingReplayRepository meetingReplayRepository(Ref ref) {
  return MeetingReplayRepositoryImpl(
    meetingRepository: ref.watch(meetingRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  );
}

// ---------------------------------------------------------------------------
// Data providers (with 5-min TTL)
// ---------------------------------------------------------------------------

@riverpod
Future<List<Meeting>> upcomingMeetings(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  final companyId = await ref.watch(companyIdProvider.future);
  if (companyId == null) return [];
  return ref
      .watch(meetingRepositoryProvider)
      .getUpcomingMeetings(companyId: companyId);
}

@riverpod
Future<List<Meeting>> meetingHistory(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  final companyId = await ref.watch(companyIdProvider.future);
  if (companyId == null) return [];
  return ref
      .watch(meetingRepositoryProvider)
      .getMeetingHistory(companyId: companyId);
}

// ---------------------------------------------------------------------------
// Derived: dashboard summary (computed from upstream providers)
// ---------------------------------------------------------------------------

@riverpod
Future<MeetingDashboardSummary> meetingDashboardSummary(Ref ref) async {
  final upcoming = await ref.watch(upcomingMeetingsProvider.future);
  final history = await ref.watch(meetingHistoryProvider.future);

  final liveCount =
      upcoming.where((m) => m.meetingStatus == MeetingStatus.live).length;
  final upcomingCount =
      upcoming.where((m) => m.meetingStatus == MeetingStatus.scheduled).length;

  // Completion: completed / (completed + cancelled) among history
  final completed =
      history.where((m) => m.meetingStatus == MeetingStatus.completed).length;
  final total = history.length;
  final completionPercent = total > 0 ? (completed / total * 100) : 0.0;

  return MeetingDashboardSummary(
    liveCount: liveCount,
    upcomingCount: upcomingCount,
    averageAttendancePercent: 0, // Requires attendance data — enriched in M3.2
    completionPercent: completionPercent,
  );
}

// ---------------------------------------------------------------------------
// Filter state
// ---------------------------------------------------------------------------

@riverpod
class SelectedMeetingFilter extends _$SelectedMeetingFilter {
  @override
  MeetingStatusFilter build() => MeetingStatusFilter.upcoming;

  void select(MeetingStatusFilter filter) => state = filter;
}

// ---------------------------------------------------------------------------
// Filtered list (reacts to filter + upstream data)
// ---------------------------------------------------------------------------

@riverpod
Future<List<Meeting>> filteredMeetings(Ref ref) async {
  final filter = ref.watch(selectedMeetingFilterProvider);

  switch (filter) {
    case MeetingStatusFilter.upcoming:
      final meetings = await ref.watch(upcomingMeetingsProvider.future);
      return meetings
          .where((m) => m.meetingStatus == MeetingStatus.scheduled)
          .toList();
    case MeetingStatusFilter.live:
      final meetings = await ref.watch(upcomingMeetingsProvider.future);
      return meetings
          .where((m) => m.meetingStatus == MeetingStatus.live)
          .toList();
    case MeetingStatusFilter.past:
      return ref.watch(meetingHistoryProvider.future);
  }
}

// ---------------------------------------------------------------------------
// Search
// ---------------------------------------------------------------------------

@riverpod
class MeetingSearchQuery extends _$MeetingSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Future<List<Meeting>> searchedMeetings(Ref ref) async {
  final query = ref.watch(meetingSearchQueryProvider).toLowerCase().trim();
  final meetings = await ref.watch(filteredMeetingsProvider.future);

  if (query.isEmpty) return meetings;

  return meetings.where((m) {
    return m.title.toLowerCase().contains(query) ||
        m.meetingCode.toLowerCase().contains(query) ||
        (m.description?.toLowerCase().contains(query) ?? false);
  }).toList();
}
