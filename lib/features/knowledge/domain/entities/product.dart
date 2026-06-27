class Product {
  final String id;
  final String companyId;
  final String name;
  final String? description;
  final String? benefits;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.companyId,
    required this.name,
    this.description,
    this.benefits,
    required this.createdAt,
  });
}
