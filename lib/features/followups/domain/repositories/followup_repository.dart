import '../../domain/entities/followup.dart';
import '../../domain/entities/followup_status.dart';
import '../../domain/entities/followup_reason_type.dart';

/// Abstract contract for follow-up reminder operations.
abstract class FollowUpRepository {
  /// Create a new follow-up reminder.
  Future<FollowUp> createFollowUp({
    required String companyId,
    required String leaderId,
    required String memberId,
    required FollowUpReasonType reasonType,
    required String reason,
    String? notes,
    DateTime? dueDate,
  });

  /// Update follow-up status or notes.
  Future<FollowUp> updateFollowUp({
    required String followupId,
    required String leaderId,
    required FollowUpStatus status,
    String? notes,
  });

  /// Complete a follow-up reminder.
  Future<FollowUp> completeFollowUp({
    required String followupId,
    required String leaderId,
    String? notes,
  });

  /// Retrieve all follow-up reminders in a company.
  Future<List<FollowUp>> getFollowUps({required String companyId});
}
