import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_faq.dart';
import '../../domain/entities/success_story.dart';
import '../../domain/repositories/knowledge_repository.dart';
import '../models/product_model.dart';
import '../models/product_faq_model.dart';
import '../models/success_story_model.dart';

class KnowledgeRepositoryImpl extends BaseRepository
    implements KnowledgeRepository {
  final supabase.SupabaseClient _client;

  KnowledgeRepositoryImpl(this._client);

  @override
  Future<List<Product>> getProducts({required String companyId}) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('company_id', companyId);
      return (response as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<ProductFaq>> getFaqs({required String productId}) async {
    try {
      final response = await _client
          .from('product_faqs')
          .select()
          .eq('product_id', productId);
      return (response as List)
          .map((e) => ProductFaqModel.fromJson(e))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<SuccessStory>> getSuccessStories({
    required String companyId,
  }) async {
    try {
      final response = await _client
          .from('success_stories')
          .select()
          .eq('company_id', companyId);
      return (response as List)
          .map((e) => SuccessStoryModel.fromJson(e))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Product> createProduct({
    required String companyId,
    required String name,
    String? description,
    String? benefits,
  }) async {
    try {
      final response =
          await _client
              .from('products')
              .insert({
                'company_id': companyId,
                'name': name,
                'description': description,
                'benefits': benefits,
              })
              .select()
              .single();
      return ProductModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<ProductFaq> createFaq({
    required String productId,
    required String question,
    required String answer,
  }) async {
    try {
      final response =
          await _client
              .from('product_faqs')
              .insert({
                'product_id': productId,
                'question': question,
                'answer': answer,
              })
              .select()
              .single();
      return ProductFaqModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<SuccessStory> createSuccessStory({
    required String companyId,
    required String title,
    String? description,
    String? youtubeUrl,
  }) async {
    try {
      final response =
          await _client
              .from('success_stories')
              .insert({
                'company_id': companyId,
                'title': title,
                'description': description,
                'youtube_url': youtubeUrl,
              })
              .select()
              .single();
      return SuccessStoryModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
