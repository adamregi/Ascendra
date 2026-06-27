import 'attendance_status.dart';

/// Domain entity representing a member's attendance record for a meeting.
///
/// Maps to the `meeting_attendances` table.
class MeetingAttendance {
  final String id;
  final String meetingId;
  final String profileId;
  final DateTime? firstJoinedAt;
  final DateTime? lastLeftAt;
  final int totalDurationMinutes;
  final double attendancePercentage;
  final AttendanceStatus attendanceStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MeetingAttendance({
    required this.id,
    required this.meetingId,
    required this.profileId,
    this.firstJoinedAt,
    this.lastLeftAt,
    required this.totalDurationMinutes,
    required this.attendancePercentage,
    required this.attendanceStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isRegistered => attendanceStatus == AttendanceStatus.registered;
  bool get isAttended => attendanceStatus == AttendanceStatus.attended;
  bool get isPartial => attendanceStatus == AttendanceStatus.partial;
  bool get isAbsent => attendanceStatus == AttendanceStatus.absent;
  bool get isExcused => attendanceStatus == AttendanceStatus.excused;
}
