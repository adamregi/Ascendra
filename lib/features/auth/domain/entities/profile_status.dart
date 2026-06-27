/// The lifecycle status of a user profile.
///
/// Matches the database constraint:
///   `check (status in ('invited', 'active', 'warned', 'suspended', 'terminated'))`
///
/// Lifecycle:
///
///   [invited]     → profile created by leader's invitation, awaiting OTP + password
///   [active]      → member completed onboarding, in good standing
///   [warned]      → missed compliance (e.g. meeting attendance), grace period started
///   [suspended]   → temporarily locked out (e.g. payment lapse, policy violation)
///   [terminated]  → permanently removed, account closed, tree restructured
///
/// State transitions:
///
///   invited → active         (member completes onboarding)
///   active  → warned         (missed compliance threshold)
///   warned  → active         (corrective action taken within grace period)
///   warned  → suspended      (grace period expired, not yet terminated)
///   active  → suspended      (immediate suspension, e.g. policy violation)
///   suspended → active       (issue resolved, reinstated by leader)
///   suspended → terminated   (permanent removal)
///   warned  → terminated     (direct termination after warning)
///
/// Note: [invited] profiles do NOT have a Supabase auth user yet.
/// The auth user is created only when the member completes onboarding.
enum ProfileStatus {
  invited,
  active,
  warned,
  suspended,
  terminated;

  /// Deserialize from the database `status` text column.
  static ProfileStatus fromString(String value) {
    switch (value) {
      case 'invited':
        return ProfileStatus.invited;
      case 'active':
        return ProfileStatus.active;
      case 'warned':
        return ProfileStatus.warned;
      case 'suspended':
        return ProfileStatus.suspended;
      case 'terminated':
        return ProfileStatus.terminated;
      default:
        throw ArgumentError('Unknown ProfileStatus: $value');
    }
  }

  /// Serialize back to the database text value.
  String toJson() => name;

  /// Whether this status allows the user to use app features.
  ///
  /// TODO: When Subscription domain is built, split this into:
  ///   - `canAuthenticate` → true for [active], [warned], [suspended]
  ///   - `canUseFeatures`  → true only for [active], [warned]
  /// Because [suspended] users can still login to see billing/renew,
  /// but cannot access the main dashboard or member features.
  bool get canAccessApp => this == active;

  /// Whether this status represents a profile that hasn't completed onboarding.
  bool get isPendingOnboarding => this == invited;
}
