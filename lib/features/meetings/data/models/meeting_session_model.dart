import '../../domain/entities/meeting_session.dart';

class MeetingSessionModel extends MeetingSession {
  const MeetingSessionModel({
    required super.id,
    required super.attendanceId,
    required super.joinedAt,
    super.leftAt,
    super.durationMinutes,
    required super.joinSource,
    required super.createdAt,
  });

  factory MeetingSessionModel.fromJson(Map<String, dynamic> json) {
    return MeetingSessionModel(
      id: json['id'] as String,
      attendanceId: json['attendance_id'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      leftAt: json['left_at'] != null ? DateTime.parse(json['left_at'] as String) : null,
      durationMinutes: json['duration_minutes'] as int?,
      joinSource: json['join_source'] as String? ?? 'mobile',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendance_id': attendanceId,
      'joined_at': joinedAt.toIso8601String(),
      'left_at': leftAt?.toIso8601String(),
      'duration_minutes': durationMinutes,
      'join_source': joinSource,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
