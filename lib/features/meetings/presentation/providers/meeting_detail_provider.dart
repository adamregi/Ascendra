import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../app/providers/repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_attendance.dart';

part 'meeting_detail_provider.g.dart';

class MeetingDetailViewModel {
  final Meeting meeting;
  final List<MeetingAttendance> attendances;
  
  // Future: Add recording status, permissions, etc.

  const MeetingDetailViewModel({
    required this.meeting,
    this.attendances = const [],
  });
}

@riverpod
Future<MeetingDetailViewModel> meetingDetail(Ref ref, String meetingId) async {
  final repo = ref.watch(meetingRepositoryProvider);
  
  final meeting = await repo.getMeeting(meetingId: meetingId);
  if (meeting == null) {
    throw Exception('Meeting not found');
  }
  
  final attendances = await repo.getMeetingAttendances(meetingId: meetingId);
  
  return MeetingDetailViewModel(
    meeting: meeting,
    attendances: attendances,
  );
}
