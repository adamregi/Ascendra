/// Domain entity representing a member's individual connection segment.
///
/// Maps to the `meeting_sessions` table.
class MeetingSession {
  final String id;
  final String attendanceId;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final int? durationMinutes;
  final String joinSource;
  final DateTime createdAt;

  const MeetingSession({
    required this.id,
    required this.attendanceId,
    required this.joinedAt,
    this.leftAt,
    this.durationMinutes,
    required this.joinSource,
    required this.createdAt,
  });

  bool get isActive => leftAt == null;
}
