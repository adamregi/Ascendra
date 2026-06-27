import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_preview_model.freezed.dart';
part 'recommendation_preview_model.g.dart';

@freezed
abstract class RecommendationPreviewModel with _$RecommendationPreviewModel {
  const factory RecommendationPreviewModel({
    @JsonKey(name: 'promotions') @Default([]) List<RecommendationItem> promotions,
    @JsonKey(name: 'mentorships') @Default([]) List<RecommendationItem> mentorships,
    @JsonKey(name: 'coaching') @Default([]) List<RecommendationItem> coaching,
    @JsonKey(name: 'training') @Default([]) List<RecommendationItem> training,
    @JsonKey(name: 'recognitions') @Default([]) List<RecommendationItem> recognitions,
  }) = _RecommendationPreviewModel;

  factory RecommendationPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationPreviewModelFromJson(json);
}

@freezed
abstract class RecommendationItem with _$RecommendationItem {
  const factory RecommendationItem({
    @JsonKey(name: 'recommendation_id') required String recommendationId,
    @JsonKey(name: 'member_name') required String memberName,
    @JsonKey(name: 'confidence_score') required double confidenceScore,
    required String reasoning,
    @JsonKey(name: 'current_leadership_score') required double currentLeadershipScore,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    
    // Optional fields that only some types have
    @JsonKey(name: 'recommended_role') String? recommendedRole,
    @JsonKey(name: 'current_risk_level') String? currentRiskLevel,
  }) = _RecommendationItem;

  factory RecommendationItem.fromJson(Map<String, dynamic> json) =>
      _$RecommendationItemFromJson(json);
}
