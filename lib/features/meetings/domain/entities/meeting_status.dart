/// The lifecycle status of a meeting.
///
/// Matches the database check:
///   `check (meeting_status in ('scheduled', 'live', 'completed', 'cancelled'))`
enum MeetingStatus {
  scheduled,
  live,
  completed,
  cancelled;

  /// Deserialize from database text column.
  static MeetingStatus fromString(String value) {
    switch (value) {
      case 'scheduled':
        return MeetingStatus.scheduled;
      case 'live':
        return MeetingStatus.live;
      case 'completed':
        return MeetingStatus.completed;
      case 'cancelled':
        return MeetingStatus.cancelled;
      default:
        throw ArgumentError('Unknown MeetingStatus: $value');
    }
  }

  /// Serialize to database text value.
  String toJson() => name;
}
