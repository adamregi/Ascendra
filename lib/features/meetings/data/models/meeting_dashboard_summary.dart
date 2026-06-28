/// Derived model for the meeting snapshot card.
///
/// Pre-computed by the provider — the widget simply renders these values.
class MeetingDashboardSummary {
  final int liveCount;
  final int upcomingCount;
  final double averageAttendancePercent;
  final double completionPercent;

  const MeetingDashboardSummary({
    required this.liveCount,
    required this.upcomingCount,
    required this.averageAttendancePercent,
    required this.completionPercent,
  });

  factory MeetingDashboardSummary.empty() {
    return const MeetingDashboardSummary(
      liveCount: 0,
      upcomingCount: 0,
      averageAttendancePercent: 0,
      completionPercent: 0,
    );
  }
}
