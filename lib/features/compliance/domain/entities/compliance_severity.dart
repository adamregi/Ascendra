enum ComplianceSeverity {
  low,
  medium,
  high,
  critical;

  String toJson() {
    switch (this) {
      case ComplianceSeverity.low:
        return 'low';
      case ComplianceSeverity.medium:
        return 'medium';
      case ComplianceSeverity.high:
        return 'high';
      case ComplianceSeverity.critical:
        return 'critical';
    }
  }

  static ComplianceSeverity fromJson(String value) {
    switch (value) {
      case 'low':
        return ComplianceSeverity.low;
      case 'medium':
        return ComplianceSeverity.medium;
      case 'high':
        return ComplianceSeverity.high;
      case 'critical':
        return ComplianceSeverity.critical;
      default:
        throw ArgumentError('Unknown ComplianceSeverity: $value');
    }
  }
}
