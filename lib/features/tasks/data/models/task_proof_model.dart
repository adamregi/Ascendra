import '../../domain/entities/task_proof.dart';

class TaskProofModel extends TaskProof {
  const TaskProofModel({
    required super.id,
    required super.assignmentId,
    required super.proofType,
    super.comment,
    super.fileUrl,
    required super.submittedAt,
  });

  factory TaskProofModel.fromJson(Map<String, dynamic> json) {
    return TaskProofModel(
      id: json['id'] as String,
      assignmentId: json['assignment_id'] as String,
      proofType: json['proof_type'] as String,
      comment: json['comment'] as String?,
      fileUrl: json['file_url'] as String?,
      submittedAt: DateTime.parse(json['submitted_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignment_id': assignmentId,
      'proof_type': proofType,
      'comment': comment,
      'file_url': fileUrl,
      'submitted_at': submittedAt.toIso8601String(),
    };
  }
}
