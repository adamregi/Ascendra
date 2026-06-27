class TerminationLog {
  final String id;
  final String profileId;
  final String companyId;
  final String terminatorId;
  final String reason;
  final String? parentReassignedTo;
  final DateTime? restructuredAt;
  final DateTime createdAt;

  const TerminationLog({
    required this.id,
    required this.profileId,
    required this.companyId,
    required this.terminatorId,
    required this.reason,
    this.parentReassignedTo,
    this.restructuredAt,
    required this.createdAt,
  });
}
