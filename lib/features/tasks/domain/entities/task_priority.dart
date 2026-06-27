enum TaskPriority {
  low,
  normal,
  high,
  urgent;

  static TaskPriority fromString(String val) {
    return TaskPriority.values.firstWhere(
      (e) => e.name == val,
      orElse: () => TaskPriority.normal,
    );
  }

  String toJson() => name;
}
