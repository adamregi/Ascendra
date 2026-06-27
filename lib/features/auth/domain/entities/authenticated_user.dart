import 'profile.dart';
import 'profile_status.dart';
import 'user_role.dart';

/// Represents a fully authenticated user in the app.
///
/// This is the **business identity** — who the user is within the
/// distributor organization. It wraps [Profile] and provides
/// convenient accessors for the fields that the app layer uses
/// most frequently (routing, authorization, display).
///
/// What this entity is:
///   - Business identity: distributor ID, role, status, company
///   - Used by the router to decide: Login or Dashboard
///   - Used by feature layers to check permissions
///
/// What this entity is NOT:
///   - Session/token management (that's infrastructure — data layer)
///   - Subscription or hierarchy data (separate bounded contexts)
///
/// No Supabase imports. No session tokens. Pure domain.
class AuthenticatedUser {
  final Profile profile;

  const AuthenticatedUser({required this.profile});

  // ── Convenience accessors ──────────────────────────────────────

  /// The user's unique ID (Supabase auth user UUID).
  String get id => profile.id;

  /// The user's business identity within the MLM organization.
  String get distributorId => profile.distributorId;

  /// The user's display name.
  String get displayName => profile.fullName;

  /// The user's phone number.
  String get phone => profile.phone;

  /// The company this user belongs to.
  String get companyId => profile.companyId;

  /// The user's role (leader or member).
  UserRole get role => profile.role;

  /// The user's compliance status.
  ProfileStatus get status => profile.status;

  // ── Domain queries ─────────────────────────────────────────────

  /// Whether this user can manage a downline team.
  bool get isLeader => profile.isLeader;

  /// Whether this user was invited but hasn't completed onboarding.
  bool get isInvited => profile.isInvited;

  /// Whether this user is in good standing.
  bool get isActive => profile.isActive;

  /// Whether this user has been temporarily suspended.
  bool get isSuspended => profile.isSuspended;

  /// Whether this user has been terminated.
  bool get isTerminated => profile.isTerminated;
}
