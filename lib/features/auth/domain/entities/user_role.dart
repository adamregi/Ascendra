/// The role assigned to a user profile.
///
/// Roles are mutually exclusive — a profile is either a [leader] or a [member].
/// However, both roles exist within the same network tree: a leader can have
/// their own upline leader above them (via `network_nodes.parent_id`).
///
/// - [leader] — Creates the company, manages downline, hosts meetings,
///              sets compliance rules.
/// - [member] — Joins via invitation, reports to a leader, attends meetings.
enum UserRole {
  leader,
  member;

  /// Deserialize from the database `role` text column.
  static UserRole fromString(String value) {
    switch (value) {
      case 'leader':
        return UserRole.leader;
      case 'member':
        return UserRole.member;
      default:
        throw ArgumentError('Unknown UserRole: $value');
    }
  }

  /// Serialize back to the database text value.
  String toJson() => name;
}
