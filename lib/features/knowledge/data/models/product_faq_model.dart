import '../../domain/entities/product_faq.dart';

class ProductFaqModel extends ProductFaq {
  const ProductFaqModel({
    required super.id,
    required super.productId,
    required super.question,
    required super.answer,
    required super.createdAt,
  });

  factory ProductFaqModel.fromJson(Map<String, dynamic> json) {
    return ProductFaqModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'question': question,
      'answer': answer,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
