enum ComplianceViolationStatus {
  open,
  acknowledged,
  resolved;

  String toJson() {
    switch (this) {
      case ComplianceViolationStatus.open:
        return 'open';
      case ComplianceViolationStatus.acknowledged:
        return 'acknowledged';
      case ComplianceViolationStatus.resolved:
        return 'resolved';
    }
  }

  static ComplianceViolationStatus fromJson(String value) {
    switch (value) {
      case 'open':
        return ComplianceViolationStatus.open;
      case 'acknowledged':
        return ComplianceViolationStatus.acknowledged;
      case 'resolved':
        return ComplianceViolationStatus.resolved;
      default:
        throw ArgumentError('Unknown ComplianceViolationStatus: $value');
    }
  }
}
