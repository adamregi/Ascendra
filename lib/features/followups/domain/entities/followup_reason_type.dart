enum FollowUpReasonType {
  missedMeeting,
  overdueTask,
  inactive,
  manual;

  static FollowUpReasonType fromString(String val) {
    if (val == 'missed_meeting') return FollowUpReasonType.missedMeeting;
    if (val == 'overdue_task') return FollowUpReasonType.overdueTask;
    return FollowUpReasonType.values.firstWhere(
      (e) => e.name == val,
      orElse: () => FollowUpReasonType.manual,
    );
  }

  String toJson() {
    if (this == FollowUpReasonType.missedMeeting) return 'missed_meeting';
    if (this == FollowUpReasonType.overdueTask) return 'overdue_task';
    return name;
  }
}
