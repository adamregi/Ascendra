import '../../domain/entities/document.dart';

class DocumentModel extends Document {
  const DocumentModel({
    required super.id,
    required super.companyId,
    required super.uploadedBy,
    required super.title,
    super.category,
    required super.fileUrl,
    required super.fileName,
    required super.storagePath,
    required super.mimeType,
    super.rawText,
    required super.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      uploadedBy: json['uploaded_by'] as String,
      title: json['title'] as String,
      category: json['category'] as String?,
      fileUrl: json['file_url'] as String,
      fileName: json['file_name'] as String,
      storagePath: json['storage_path'] as String,
      mimeType: json['mime_type'] as String,
      rawText: json['raw_text'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'uploaded_by': uploadedBy,
      'title': title,
      'category': category,
      'file_url': fileUrl,
      'file_name': fileName,
      'storage_path': storagePath,
      'mime_type': mimeType,
      'raw_text': rawText,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
