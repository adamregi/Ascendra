import '../../domain/entities/meeting_status.dart';

/// Filter options for the meetings list view.
///
/// Extensible enum — add new filter values here without modifying widget code.
enum MeetingStatusFilter {
  upcoming('Upcoming', [MeetingStatus.scheduled]),
  live('Live', [MeetingStatus.live]),
  past('Past', [MeetingStatus.completed, MeetingStatus.cancelled]);

  final String label;
  final List<MeetingStatus> statuses;

  const MeetingStatusFilter(this.label, this.statuses);
}
