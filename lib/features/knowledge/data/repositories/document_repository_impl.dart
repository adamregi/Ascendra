import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_chunk.dart';
import '../../domain/repositories/document_repository.dart';
import '../models/document_model.dart';
import '../models/document_chunk_model.dart';
import '../../utils/text_chunker.dart';
import '../../utils/mock_embedding_provider.dart';

class DocumentRepositoryImpl extends BaseRepository implements DocumentRepository {
  final supabase.SupabaseClient _client;

  DocumentRepositoryImpl(this._client);

  @override
  Future<Document> uploadDocument({
    required String companyId,
    required String uploaderId,
    required String title,
    String? category,
    required String rawText,
  }) async {
    try {
      // 1. Create the Document record
      // Simulating a file upload by using a fake URL and path
      final docResponse = await _client.from('documents').insert({
        'company_id': companyId,
        'uploaded_by': uploaderId,
        'title': title,
        'category': category,
        'file_url': 'https://example.com/dummy.pdf',
        'file_name': '\$title.pdf',
        'storage_path': 'documents/\$companyId/\$title.pdf',
        'mime_type': 'application/pdf',
        'raw_text': rawText,
      }).select().single();
      
      final document = DocumentModel.fromJson(docResponse);
      
      // 2. Chunk the text
      final chunks = TextChunker.chunkText(rawText);
      
      // 3. Generate embeddings and save chunks
      if (chunks.isNotEmpty) {
        final List<Map<String, dynamic>> chunkInserts = [];
        for (final textChunk in chunks) {
          final embedding = MockEmbeddingProvider.generateMockEmbedding(textChunk);
          chunkInserts.add({
            'document_id': document.id,
            'chunk_text': textChunk,
            'embedding': embedding,
          });
        }
        
        await _client.from('document_chunks').insert(chunkInserts);
      }
      
      return document;
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Document>> getDocuments({required String companyId}) async {
    try {
      final response = await _client.from('documents').select().eq('company_id', companyId);
      return (response as List).map((e) => DocumentModel.fromJson(e)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<DocumentChunk>> searchDocuments({
    required String companyId,
    required String query,
    int matchCount = 5,
    double matchThreshold = 0.5,
  }) async {
    try {
      // Convert query to embedding
      final queryEmbedding = MockEmbeddingProvider.generateMockEmbedding(query);
      
      // Call RPC
      final response = await _client.rpc('match_document_chunks', params: {
        'query_embedding': queryEmbedding,
        'match_threshold': matchThreshold,
        'match_count': matchCount,
        'p_company_id': companyId,
      });
      
      return (response as List).map((e) => DocumentChunkModel.fromJson(e)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
