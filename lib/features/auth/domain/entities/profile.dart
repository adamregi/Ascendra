import 'user_role.dart';
import 'profile_status.dart';

/// Domain entity representing a user profile.
///
/// Maps to the `profiles` table:
///   id, distributor_id, full_name, phone, company_id,
///   role, status, warned_at, terminated_at, created_at, updated_at
///
/// This is a pure domain object — no Supabase imports, no JSON logic.
/// Serialization will live in the data layer (repository / DTO).
class Profile {
  /// Supabase auth user ID (UUID from `auth.users`).
  final String id;

  /// The user's business identity within the MLM organization.
  ///
  /// This is NOT merely a login credential — it is the equivalent of
  /// an employee number or member number. The entire organization
  /// recognizes people by their Distributor ID.
  final String distributorId;

  /// The user's display name.
  final String fullName;

  /// The user's phone number (used for OTP authentication).
  final String phone;

  /// The company this profile belongs to.
  final String companyId;

  /// The role assigned to this profile.
  final UserRole role;

  /// The compliance status of this profile.
  final ProfileStatus status;

  /// When this profile was warned (missed compliance).
  final DateTime? warnedAt;

  /// When this profile was terminated.
  final DateTime? terminatedAt;

  /// When this profile was created.
  final DateTime createdAt;

  /// When this profile was last updated.
  final DateTime updatedAt;

  const Profile({
    required this.id,
    required this.distributorId,
    required this.fullName,
    required this.phone,
    required this.companyId,
    required this.role,
    required this.status,
    this.warnedAt,
    this.terminatedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Whether this profile can manage a downline team.
  bool get isLeader => role == UserRole.leader;

  /// Whether this profile was created via invitation but hasn't completed onboarding.
  bool get isInvited => status == ProfileStatus.invited;

  /// Whether this profile is still in good standing.
  bool get isActive => status == ProfileStatus.active;

  /// Whether this profile has been temporarily suspended.
  bool get isSuspended => status == ProfileStatus.suspended;

  /// Whether this profile has been terminated and can no longer access the app.
  bool get isTerminated => status == ProfileStatus.terminated;
}
