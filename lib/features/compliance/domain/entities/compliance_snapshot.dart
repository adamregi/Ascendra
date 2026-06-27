class ComplianceSnapshot {
  final String id;
  final String profileId;
  final String companyId;
  final double attendanceScore;
  final double taskScore;
  final double followupScore;
  final double complianceScore;
  final double memberHealthScore;
  final double? teamHealthScore;
  final DateTime snapshotDate;
  final DateTime createdAt;

  const ComplianceSnapshot({
    required this.id,
    required this.profileId,
    required this.companyId,
    required this.attendanceScore,
    required this.taskScore,
    required this.followupScore,
    required this.complianceScore,
    required this.memberHealthScore,
    this.teamHealthScore,
    required this.snapshotDate,
    required this.createdAt,
  });
}
