import '../../domain/entities/attendance_status.dart';
import '../../domain/entities/meeting_attendance.dart';

class MeetingAttendanceModel extends MeetingAttendance {
  const MeetingAttendanceModel({
    required super.id,
    required super.meetingId,
    required super.profileId,
    super.firstJoinedAt,
    super.lastLeftAt,
    required super.totalDurationMinutes,
    required super.attendancePercentage,
    required super.attendanceStatus,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MeetingAttendanceModel.fromJson(Map<String, dynamic> json) {
    return MeetingAttendanceModel(
      id: json['id'] as String,
      meetingId: json['meeting_id'] as String,
      profileId: json['profile_id'] as String,
      firstJoinedAt:
          json['first_joined_at'] != null
              ? DateTime.parse(json['first_joined_at'] as String)
              : null,
      lastLeftAt:
          json['last_left_at'] != null
              ? DateTime.parse(json['last_left_at'] as String)
              : null,
      totalDurationMinutes: json['total_duration_minutes'] as int? ?? 0,
      attendancePercentage:
          (json['attendance_percentage'] as num? ?? 0.0).toDouble(),
      attendanceStatus: AttendanceStatus.fromString(
        json['attendance_status'] as String,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'profile_id': profileId,
      'first_joined_at': firstJoinedAt?.toIso8601String(),
      'last_left_at': lastLeftAt?.toIso8601String(),
      'total_duration_minutes': totalDurationMinutes,
      'attendance_percentage': attendancePercentage,
      'attendance_status': attendanceStatus.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
