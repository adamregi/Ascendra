enum AssignmentStatus {
  assigned,
  inProgress,
  submitted,
  approved,
  rejected,
  overdue,
  cancelled;

  static AssignmentStatus fromString(String val) {
    if (val == 'in_progress') return AssignmentStatus.inProgress;
    return AssignmentStatus.values.firstWhere(
      (e) => e.name == val,
      orElse: () => AssignmentStatus.assigned,
    );
  }

  String toJson() {
    if (this == AssignmentStatus.inProgress) return 'in_progress';
    return name;
  }
}
