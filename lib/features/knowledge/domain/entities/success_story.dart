class SuccessStory {
  final String id;
  final String companyId;
  final String title;
  final String? description;
  final String? youtubeUrl;
  final DateTime createdAt;

  const SuccessStory({
    required this.id,
    required this.companyId,
    required this.title,
    this.description,
    this.youtubeUrl,
    required this.createdAt,
  });
}
