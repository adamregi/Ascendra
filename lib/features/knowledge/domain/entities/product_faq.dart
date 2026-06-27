class ProductFaq {
  final String id;
  final String productId;
  final String question;
  final String answer;
  final DateTime createdAt;

  const ProductFaq({
    required this.id,
    required this.productId,
    required this.question,
    required this.answer,
    required this.createdAt,
  });
}
