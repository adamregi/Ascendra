import '../../domain/entities/success_story.dart';

class SuccessStoryModel extends SuccessStory {
  const SuccessStoryModel({
    required super.id,
    required super.companyId,
    required super.title,
    super.description,
    super.youtubeUrl,
    required super.createdAt,
  });

  factory SuccessStoryModel.fromJson(Map<String, dynamic> json) {
    return SuccessStoryModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      youtubeUrl: json['youtube_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'title': title,
      'description': description,
      'youtube_url': youtubeUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
