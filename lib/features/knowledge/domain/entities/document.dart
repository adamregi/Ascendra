class Document {
  final String id;
  final String companyId;
  final String uploadedBy;
  final String title;
  final String? category;
  final String fileUrl;
  final String fileName;
  final String storagePath;
  final String mimeType;
  final String? rawText;
  final DateTime createdAt;

  const Document({
    required this.id,
    required this.companyId,
    required this.uploadedBy,
    required this.title,
    this.category,
    required this.fileUrl,
    required this.fileName,
    required this.storagePath,
    required this.mimeType,
    this.rawText,
    required this.createdAt,
  });
}
