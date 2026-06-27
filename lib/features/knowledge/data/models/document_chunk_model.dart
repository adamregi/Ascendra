import '../../domain/entities/document_chunk.dart';

class DocumentChunkModel extends DocumentChunk {
  const DocumentChunkModel({
    required super.id,
    required super.documentId,
    required super.chunkText,
  });

  factory DocumentChunkModel.fromJson(Map<String, dynamic> json) {
    return DocumentChunkModel(
      id: json['id'] as String,
      documentId: json['document_id'] as String,
      chunkText: json['chunk_text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document_id': documentId,
      'chunk_text': chunkText,
    };
  }
}
