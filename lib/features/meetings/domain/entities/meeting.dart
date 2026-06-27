import 'meeting_status.dart';

/// Domain entity representing a video meeting.
///
/// Maps to the `meetings` table.
class Meeting {
  final String id;
  final String companyId;
  final String leaderId;
  final String meetingCode;
  final String title;
  final String? description;
  final String? agenda;
  final String? meetingUrl;
  final String? roomId;
  final MeetingStatus meetingStatus;
  final DateTime scheduledAt;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int? durationMinutes;
  final bool recordingEnabled;
  final String? recordingUrl;
  final bool lateJoinAllowed;
  final int? lateJoinCutoffMinutes;
  final int? maxParticipants;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Meeting({
    required this.id,
    required this.companyId,
    required this.leaderId,
    required this.meetingCode,
    required this.title,
    this.description,
    this.agenda,
    this.meetingUrl,
    this.roomId,
    required this.meetingStatus,
    required this.scheduledAt,
    this.startedAt,
    this.endedAt,
    this.durationMinutes,
    required this.recordingEnabled,
    this.recordingUrl,
    required this.lateJoinAllowed,
    this.lateJoinCutoffMinutes,
    this.maxParticipants,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isScheduled => meetingStatus == MeetingStatus.scheduled;
  bool get isLive => meetingStatus == MeetingStatus.live;
  bool get isCompleted => meetingStatus == MeetingStatus.completed;
  bool get isCancelled => meetingStatus == MeetingStatus.cancelled;
}
