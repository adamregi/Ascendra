import '../../domain/entities/invitation.dart';
import '../../domain/entities/invitation_status.dart';

class InvitationModel extends Invitation {
  const InvitationModel({
    required super.id,
    required super.inviterId,
    required super.distributorId,
    required super.fullName,
    required super.phone,
    required super.companyId,
    required super.status,
    required super.invitedAt,
    super.acceptedAt,
    super.expiresAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'] as String,
      inviterId: json['inviter_id'] as String,
      distributorId: json['distributor_id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      companyId: json['company_id'] as String,
      status: InvitationStatus.fromString(json['status'] as String),
      invitedAt: DateTime.parse(json['invited_at'] as String),
      acceptedAt:
          json['accepted_at'] != null
              ? DateTime.parse(json['accepted_at'] as String)
              : null,
      expiresAt:
          json['expires_at'] != null
              ? DateTime.parse(json['expires_at'] as String)
              : null,
    );
  }
}
