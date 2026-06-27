enum TaskStatus {
  draft,
  assigned,
  active,
  completed,
  cancelled;

  static TaskStatus fromString(String val) {
    return TaskStatus.values.firstWhere(
      (e) => e.name == val,
      orElse: () => TaskStatus.draft,
    );
  }

  String toJson() => name;
}
