enum ComplianceEventType {
  missedMeeting,
  partialAttendance,
  taskOverdue,
  inactive,
  followupMissed;

  String toJson() {
    switch (this) {
      case ComplianceEventType.missedMeeting:
        return 'missed_meeting';
      case ComplianceEventType.partialAttendance:
        return 'partial_attendance';
      case ComplianceEventType.taskOverdue:
        return 'task_overdue';
      case ComplianceEventType.inactive:
        return 'inactive';
      case ComplianceEventType.followupMissed:
        return 'followup_missed';
    }
  }

  static ComplianceEventType fromJson(String value) {
    switch (value) {
      case 'missed_meeting':
        return ComplianceEventType.missedMeeting;
      case 'partial_attendance':
        return ComplianceEventType.partialAttendance;
      case 'task_overdue':
        return ComplianceEventType.taskOverdue;
      case 'inactive':
        return ComplianceEventType.inactive;
      case 'followup_missed':
        return ComplianceEventType.followupMissed;
      default:
        throw ArgumentError('Unknown ComplianceEventType: $value');
    }
  }
}
