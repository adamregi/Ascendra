import 'compliance_event_type.dart';

class ComplianceEvent {
  final String id;
  final String profileId;
  final String companyId;
  final ComplianceEventType eventType;
  final String? eventValue;
  final String sourceId;
  final DateTime occurredAt;

  const ComplianceEvent({
    required this.id,
    required this.profileId,
    required this.companyId,
    required this.eventType,
    this.eventValue,
    required this.sourceId,
    required this.occurredAt,
  });
}
