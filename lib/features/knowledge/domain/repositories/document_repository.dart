import '../entities/document.dart';
import '../entities/document_chunk.dart';

abstract class DocumentRepository {
  /// Simulates uploading a document by providing its raw text.
  /// In a real scenario, this would take a File, upload it to Supabase Storage,
  /// parse the text using an OCR or PDF library, chunk it, embed it, and save it.
  Future<Document> uploadDocument({
    required String companyId,
    required String uploaderId,
    required String title,
    String? category,
    required String rawText,
  });

  /// Retrieves all documents for a company.
  Future<List<Document>> getDocuments({required String companyId});

  /// Performs a vector search over document chunks based on a query text.
  Future<List<DocumentChunk>> searchDocuments({
    required String companyId,
    required String query,
    int matchCount = 5,
    double matchThreshold = 0.5,
  });
}
