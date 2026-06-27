import 'followup_status.dart';
import 'followup_reason_type.dart';

class FollowUp {
  final String id;
  final String companyId;
  final String leaderId;
  final String memberId;
  final FollowUpReasonType reasonType;
  final String reason;
  final String? notes;
  final DateTime? dueDate;
  final FollowUpStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FollowUp({
    required this.id,
    required this.companyId,
    required this.leaderId,
    required this.memberId,
    required this.reasonType,
    required this.reason,
    this.notes,
    this.dueDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
