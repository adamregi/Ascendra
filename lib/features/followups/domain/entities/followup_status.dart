enum FollowUpStatus {
  open,
  inProgress,
  completed,
  cancelled;

  static FollowUpStatus fromString(String val) {
    if (val == 'in_progress') return FollowUpStatus.inProgress;
    return FollowUpStatus.values.firstWhere(
      (e) => e.name == val,
      orElse: () => FollowUpStatus.open,
    );
  }

  String toJson() {
    if (this == FollowUpStatus.inProgress) return 'in_progress';
    return name;
  }
}
