// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_profile_rpc_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberProfileRpcDto _$MemberProfileRpcDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileRpcDto(
  version: (json['version'] as num).toInt(),
  generatedAt: DateTime.parse(json['generated_at'] as String),
  hero: MemberProfileHeroDto.fromJson(json['hero'] as Map<String, dynamic>),
  overview: MemberProfileOverviewDto.fromJson(
    json['overview'] as Map<String, dynamic>,
  ),
  compliance: MemberProfileComplianceDto.fromJson(
    json['compliance'] as Map<String, dynamic>,
  ),
  timeline:
      (json['timeline'] as List<dynamic>)
          .map(
            (e) => MemberProfileTimelineDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  recognition:
      (json['recognition'] as List<dynamic>)
          .map(
            (e) =>
                MemberProfileRecognitionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  analytics: MemberProfileAnalyticsDto.fromJson(
    json['analytics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MemberProfileRpcDtoToJson(
  _MemberProfileRpcDto instance,
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

_MemberProfileHeroDto _$MemberProfileHeroDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileHeroDto(
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

Map<String, dynamic> _$MemberProfileHeroDtoToJson(
  _MemberProfileHeroDto instance,
) => <String, dynamic>{
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

_MemberProfileOverviewDto _$MemberProfileOverviewDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileOverviewDto(
  leadershipScore: (json['leadership_score'] as num).toInt(),
  recognitionCount: (json['recognition_count'] as num).toInt(),
  complianceScore: (json['compliance_score'] as num).toInt(),
  meetingPercent: (json['meeting_percent'] as num).toDouble(),
  taskPercent: (json['task_percent'] as num).toDouble(),
  riskLevel: json['risk_level'] as String,
);

Map<String, dynamic> _$MemberProfileOverviewDtoToJson(
  _MemberProfileOverviewDto instance,
) => <String, dynamic>{
  'leadership_score': instance.leadershipScore,
  'recognition_count': instance.recognitionCount,
  'compliance_score': instance.complianceScore,
  'meeting_percent': instance.meetingPercent,
  'task_percent': instance.taskPercent,
  'risk_level': instance.riskLevel,
};

_MemberProfileComplianceDto _$MemberProfileComplianceDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileComplianceDto(
  score: (json['score'] as num).toInt(),
  reasons: (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
  nextImprovement: json['next_improvement'] as String,
);

Map<String, dynamic> _$MemberProfileComplianceDtoToJson(
  _MemberProfileComplianceDto instance,
) => <String, dynamic>{
  'score': instance.score,
  'reasons': instance.reasons,
  'next_improvement': instance.nextImprovement,
};

_MemberProfileTimelineDto _$MemberProfileTimelineDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileTimelineDto(
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$MemberProfileTimelineDtoToJson(
  _MemberProfileTimelineDto instance,
) => <String, dynamic>{
  'type': instance.type,
  'timestamp': instance.timestamp.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
};

_MemberProfileRecognitionDto _$MemberProfileRecognitionDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileRecognitionDto(
  name: json['name'] as String,
  description: json['description'] as String,
  earnedDate: DateTime.parse(json['earned_date'] as String),
  category: json['category'] as String,
  icon: json['icon'] as String,
  level: (json['level'] as num).toInt(),
  points: (json['points'] as num).toInt(),
);

Map<String, dynamic> _$MemberProfileRecognitionDtoToJson(
  _MemberProfileRecognitionDto instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'earned_date': instance.earnedDate.toIso8601String(),
  'category': instance.category,
  'icon': instance.icon,
  'level': instance.level,
  'points': instance.points,
};

_MemberProfileAnalyticsDto _$MemberProfileAnalyticsDtoFromJson(
  Map<String, dynamic> json,
) => _MemberProfileAnalyticsDto(
  leadershipTrend:
      (json['leadership_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  attendanceTrend:
      (json['attendance_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  taskTrend:
      (json['task_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$MemberProfileAnalyticsDtoToJson(
  _MemberProfileAnalyticsDto instance,
) => <String, dynamic>{
  'leadership_trend': instance.leadershipTrend,
  'attendance_trend': instance.attendanceTrend,
  'task_trend': instance.taskTrend,
};
