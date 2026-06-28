import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_status.dart';

class MeetingModel extends Meeting {
  const MeetingModel({
    required super.id,
    required super.companyId,
    required super.leaderId,
    required super.meetingCode,
    required super.title,
    super.description,
    super.agenda,
    super.meetingUrl,
    super.roomId,
    required super.meetingStatus,
    required super.scheduledAt,
    super.startedAt,
    super.endedAt,
    super.durationMinutes,
    required super.recordingEnabled,
    super.recordingUrl,
    required super.lateJoinAllowed,
    super.lateJoinCutoffMinutes,
    super.maxParticipants,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      leaderId: json['leader_id'] as String,
      meetingCode: json['meeting_code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      agenda: json['agenda'] as String?,
      meetingUrl: json['meeting_url'] as String?,
      roomId: json['room_id'] as String?,
      meetingStatus: MeetingStatus.fromString(json['meeting_status'] as String),
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      startedAt:
          json['started_at'] != null
              ? DateTime.parse(json['started_at'] as String)
              : null,
      endedAt:
          json['ended_at'] != null
              ? DateTime.parse(json['ended_at'] as String)
              : null,
      durationMinutes: json['duration_minutes'] as int?,
      recordingEnabled: json['recording_enabled'] as bool? ?? false,
      recordingUrl: json['recording_url'] as String?,
      lateJoinAllowed: json['late_join_allowed'] as bool? ?? true,
      lateJoinCutoffMinutes: json['late_join_cutoff_minutes'] as int?,
      maxParticipants: json['max_participants'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'leader_id': leaderId,
      'meeting_code': meetingCode,
      'title': title,
      'description': description,
      'agenda': agenda,
      'meeting_url': meetingUrl,
      'room_id': roomId,
      'meeting_status': meetingStatus.toJson(),
      'scheduled_at': scheduledAt.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'ended_at': endedAt?.toIso8601String(),
      'duration_minutes': durationMinutes,
      'recording_enabled': recordingEnabled,
      'recording_url': recordingUrl,
      'late_join_allowed': lateJoinAllowed,
      'late_join_cutoff_minutes': lateJoinCutoffMinutes,
      'max_participants': maxParticipants,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
