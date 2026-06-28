enum TaskProofType {
  text,
  image,
  pdf,
  url;

  static TaskProofType fromString(String val) {
    return TaskProofType.values.firstWhere(
      (e) => e.name == val,
      orElse: () => TaskProofType.text,
    );
  }

  String toJson() => name;
}

enum TaskProofStatus {
  pending,
  approved,
  rejected;

  static TaskProofStatus fromString(String val) {
    return TaskProofStatus.values.firstWhere(
      (e) => e.name == val,
      orElse: () => TaskProofStatus.pending,
    );
  }

  String toJson() => name;
}

class TaskProof {
  final String id;
  final String taskId;
  final String submittedBy;
  final TaskProofType proofType;
  final String? text;
  final String? url;
  final String? storagePath;
  final String? fileName;
  final String? mimeType;
  final int? fileSize;
  final TaskProofStatus status;
  final String? reviewComment;
  final DateTime createdAt;

  const TaskProof({
    required this.id,
    required this.taskId,
    required this.submittedBy,
    required this.proofType,
    this.text,
    this.url,
    this.storagePath,
    this.fileName,
    this.mimeType,
    this.fileSize,
    required this.status,
    this.reviewComment,
    required this.createdAt,
  });

  factory TaskProof.fromJson(Map<String, dynamic> json) {
    return TaskProof(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      submittedBy: json['submitted_by'] as String,
      proofType: TaskProofType.fromString(json['proof_type'] as String),
      text: json['text'] as String?,
      url: json['url'] as String?,
      storagePath: json['storage_path'] as String?,
      fileName: json['file_name'] as String?,
      mimeType: json['mime_type'] as String?,
      fileSize: json['file_size'] as int?,
      status: TaskProofStatus.fromString(json['status'] as String),
      reviewComment: json['review_comment'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'submitted_by': submittedBy,
      'proof_type': proofType.toJson(),
      'text': text,
      'url': url,
      'storage_path': storagePath,
      'file_name': fileName,
      'mime_type': mimeType,
      'file_size': fileSize,
      'status': status.toJson(),
      'review_comment': reviewComment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
