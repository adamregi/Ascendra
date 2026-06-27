import '../entities/product.dart';
import '../entities/product_faq.dart';
import '../entities/success_story.dart';

abstract class KnowledgeRepository {
  Future<List<Product>> getProducts({required String companyId});
  Future<List<ProductFaq>> getFaqs({required String productId});
  Future<List<SuccessStory>> getSuccessStories({required String companyId});

  // Basic creation methods for tests / admin side
  Future<Product> createProduct({
    required String companyId,
    required String name,
    String? description,
    String? benefits,
  });

  Future<ProductFaq> createFaq({
    required String productId,
    required String question,
    required String answer,
  });

  Future<SuccessStory> createSuccessStory({
    required String companyId,
    required String title,
    String? description,
    String? youtubeUrl,
  });
}
