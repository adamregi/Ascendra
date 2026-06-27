class TaskProof {
  final String id;
  final String assignmentId;
  final String proofType;
  final String? comment;
  final String? fileUrl;
  final DateTime submittedAt;

  const TaskProof({
    required this.id,
    required this.assignmentId,
    required this.proofType,
    this.comment,
    this.fileUrl,
    required this.submittedAt,
  });
}
