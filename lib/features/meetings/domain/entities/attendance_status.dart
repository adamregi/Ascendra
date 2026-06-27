/// The attendance status of a member for a meeting.
///
/// Matches the database check:
///   `check (attendance_status in ('registered', 'attended', 'partial', 'absent', 'excused'))`
enum AttendanceStatus {
  registered,
  attended,
  partial,
  absent,
  excused;

  /// Deserialize from database text column.
  static AttendanceStatus fromString(String value) {
    switch (value) {
      case 'registered':
        return AttendanceStatus.registered;
      case 'attended':
        return AttendanceStatus.attended;
      case 'partial':
        return AttendanceStatus.partial;
      case 'absent':
        return AttendanceStatus.absent;
      case 'excused':
        return AttendanceStatus.excused;
      default:
        throw ArgumentError('Unknown AttendanceStatus: $value');
    }
  }

  /// Serialize to database text value.
  String toJson() => name;
}
