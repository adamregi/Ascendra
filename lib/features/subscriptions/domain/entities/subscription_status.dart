/// The lifecycle status of a subscription.
///
/// Matches the database constraint:
///   `check (status in ('active', 'expired', 'cancelled'))`
///
/// This is entirely separate from [ProfileStatus]:
///
///   ProfileStatus    → controls identity (can you log in?)
///   SubscriptionStatus → controls platform access (can you use features?)
///
/// Example of the distinction:
///
///   Profile Status      = active
///   Subscription Status = expired
///
///   User:
///     Can login            ✅
///     Can renew            ✅
///     Can manage team      ❌
///     Can invite members   ❌
///     Can create meetings  ❌
///     Can use AI           ❌
///
/// Lifecycle:
///
///   [active]    → subscription is paid and within the billing period
///   [expired]   → billing period ended, user must renew to regain access
///   [cancelled] → leader explicitly cancelled the subscription
///
/// State transitions:
///
///   active → expired       (billing period ends without renewal)
///   active → cancelled     (leader cancels subscription)
///   expired → active       (leader renews / pays again)
///   cancelled → active     (leader re-subscribes)
enum SubscriptionStatus {
  active,
  expired,
  cancelled;

  /// Deserialize from the database `status` text column.
  static SubscriptionStatus fromString(String value) {
    switch (value) {
      case 'active':
        return SubscriptionStatus.active;
      case 'expired':
        return SubscriptionStatus.expired;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      default:
        throw ArgumentError('Unknown SubscriptionStatus: $value');
    }
  }

  /// Serialize back to the database text value.
  String toJson() => name;

  /// Whether this subscription grants access to platform features.
  bool get grantsAccess => this == active;
}
