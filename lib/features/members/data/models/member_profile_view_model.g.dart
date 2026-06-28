// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_profile_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberProfileViewModel _$MemberProfileViewModelFromJson(
  Map<String, dynamic> json,
) => _MemberProfileViewModel(
  version: (json['version'] as num).toInt(),
  generatedAt: DateTime.parse(json['generated_at'] as String),
  hero: MemberHeroModel.fromJson(json['hero'] as Map<String, dynamic>),
  overview: MemberOverviewModel.fromJson(
    json['overview'] as Map<String, dynamic>,
  ),
  compliance: MemberComplianceModel.fromJson(
    json['compliance'] as Map<String, dynamic>,
  ),
  timeline:
      (json['timeline'] as List<dynamic>)
          .map(
            (e) => MemberTimelineEventModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  recognition:
      (json['recognition'] as List<dynamic>)
          .map(
            (e) => MemberRecognitionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  analytics: MemberAnalyticsModel.fromJson(
    json['analytics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MemberProfileViewModelToJson(
  _MemberProfileViewModel instance,
) => <String, dynamic>{
  'version': instance.version,
  'generated_at': instance.generatedAt.toIso8601String(),
  'hero': instance.hero,
  'overview': instance.overview,
  'compliance': instance.compliance,
  'timeline': instance.timeline,
  'recognition': instance.recognition,
  'analytics': instance.analytics,
};

_MemberHeroModel _$MemberHeroModelFromJson(Map<String, dynamic> json) =>
    _MemberHeroModel(
      avatarUrl: json['avatar_url'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      distributorId: json['distributor_id'] as String,
      leaderName: json['leader_name'] as String?,
      rank: json['rank'] as String,
      status: json['status'] as String,
      joinedDate: DateTime.parse(json['joined_date'] as String),
      currentStreak: (json['current_streak'] as num).toInt(),
    );

Map<String, dynamic> _$MemberHeroModelToJson(_MemberHeroModel instance) =>
    <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'distributor_id': instance.distributorId,
      'leader_name': instance.leaderName,
      'rank': instance.rank,
      'status': instance.status,
      'joined_date': instance.joinedDate.toIso8601String(),
      'current_streak': instance.currentStreak,
    };

_MemberOverviewModel _$MemberOverviewModelFromJson(Map<String, dynamic> json) =>
    _MemberOverviewModel(
      leadershipScore: (json['leadership_score'] as num).toInt(),
      recognitionCount: (json['recognition_count'] as num).toInt(),
      complianceScore: (json['compliance_score'] as num).toInt(),
      meetingPercent: (json['meeting_percent'] as num).toInt(),
      taskPercent: (json['task_percent'] as num).toInt(),
      riskLevel: json['risk_level'] as String,
    );

Map<String, dynamic> _$MemberOverviewModelToJson(
  _MemberOverviewModel instance,
) => <String, dynamic>{
  'leadership_score': instance.leadershipScore,
  'recognition_count': instance.recognitionCount,
  'compliance_score': instance.complianceScore,
  'meeting_percent': instance.meetingPercent,
  'task_percent': instance.taskPercent,
  'risk_level': instance.riskLevel,
};

_MemberComplianceModel _$MemberComplianceModelFromJson(
  Map<String, dynamic> json,
) => _MemberComplianceModel(
  score: (json['score'] as num).toInt(),
  reasons: (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
  nextImprovement: json['next_improvement'] as String,
);

Map<String, dynamic> _$MemberComplianceModelToJson(
  _MemberComplianceModel instance,
) => <String, dynamic>{
  'score': instance.score,
  'reasons': instance.reasons,
  'next_improvement': instance.nextImprovement,
};
