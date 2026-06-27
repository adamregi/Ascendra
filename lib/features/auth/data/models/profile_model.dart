import '../../domain/entities/profile.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/entities/profile_status.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.distributorId,
    required super.fullName,
    required super.phone,
    required super.companyId,
    required super.role,
    required super.status,
    super.warnedAt,
    super.terminatedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      distributorId: json['distributor_id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      companyId: json['company_id'] as String,
      role: UserRole.fromString(json['role'] as String),
      status: ProfileStatus.fromString(json['status'] as String),
      warnedAt: json['warned_at'] != null ? DateTime.parse(json['warned_at'] as String) : null,
      terminatedAt: json['terminated_at'] != null ? DateTime.parse(json['terminated_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
