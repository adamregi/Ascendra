// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecommendationPreviewModel _$RecommendationPreviewModelFromJson(
  Map<String, dynamic> json,
) => _RecommendationPreviewModel(
  promotions:
      (json['promotions'] as List<dynamic>?)
          ?.map((e) => RecommendationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mentorships:
      (json['mentorships'] as List<dynamic>?)
          ?.map((e) => RecommendationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  coaching:
      (json['coaching'] as List<dynamic>?)
          ?.map((e) => RecommendationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  training:
      (json['training'] as List<dynamic>?)
          ?.map((e) => RecommendationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  recognitions:
      (json['recognitions'] as List<dynamic>?)
          ?.map((e) => RecommendationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RecommendationPreviewModelToJson(
  _RecommendationPreviewModel instance,
) => <String, dynamic>{
  'promotions': instance.promotions,
  'mentorships': instance.mentorships,
  'coaching': instance.coaching,
  'training': instance.training,
  'recognitions': instance.recognitions,
};

_RecommendationItem _$RecommendationItemFromJson(Map<String, dynamic> json) =>
    _RecommendationItem(
      recommendationId: json['recommendation_id'] as String,
      memberName: json['member_name'] as String,
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      reasoning: json['reasoning'] as String,
      currentLeadershipScore:
          (json['current_leadership_score'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      recommendedRole: json['recommended_role'] as String?,
      currentRiskLevel: json['current_risk_level'] as String?,
    );

Map<String, dynamic> _$RecommendationItemToJson(_RecommendationItem instance) =>
    <String, dynamic>{
      'recommendation_id': instance.recommendationId,
      'member_name': instance.memberName,
      'confidence_score': instance.confidenceScore,
      'reasoning': instance.reasoning,
      'current_leadership_score': instance.currentLeadershipScore,
      'created_at': instance.createdAt.toIso8601String(),
      'recommended_role': instance.recommendedRole,
      'current_risk_level': instance.currentRiskLevel,
    };
