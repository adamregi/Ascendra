import '../../domain/entities/compliance_event.dart';
import '../../domain/entities/compliance_event_type.dart';

class ComplianceEventModel extends ComplianceEvent {
  const ComplianceEventModel({
    required super.id,
    required super.profileId,
    required super.companyId,
    required super.eventType,
    super.eventValue,
    required super.sourceId,
    required super.occurredAt,
  });

  factory ComplianceEventModel.fromJson(Map<String, dynamic> json) {
    return ComplianceEventModel(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      companyId: json['company_id'] as String,
      eventType: ComplianceEventType.fromJson(json['event_type'] as String),
      eventValue: json['event_value'] as String?,
      sourceId: json['source_id'] as String,
      occurredAt: DateTime.parse(json['occurred_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'company_id': companyId,
      'event_type': eventType.toJson(),
      'event_value': eventValue,
      'source_id': sourceId,
      'occurred_at': occurredAt.toIso8601String(),
    };
  }
}
