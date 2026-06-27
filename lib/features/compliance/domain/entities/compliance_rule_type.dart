enum ComplianceRuleType {
  attendancePercentage,
  overdueTasks,
  inactiveDays,
  openFollowups;

  String toJson() {
    switch (this) {
      case ComplianceRuleType.attendancePercentage:
        return 'attendance_percentage';
      case ComplianceRuleType.overdueTasks:
        return 'overdue_tasks';
      case ComplianceRuleType.inactiveDays:
        return 'inactive_days';
      case ComplianceRuleType.openFollowups:
        return 'open_followups';
    }
  }

  static ComplianceRuleType fromJson(String value) {
    switch (value) {
      case 'attendance_percentage':
        return ComplianceRuleType.attendancePercentage;
      case 'overdue_tasks':
        return ComplianceRuleType.overdueTasks;
      case 'inactive_days':
        return ComplianceRuleType.inactiveDays;
      case 'open_followups':
        return ComplianceRuleType.openFollowups;
      default:
        throw ArgumentError('Unknown ComplianceRuleType: $value');
    }
  }
}
