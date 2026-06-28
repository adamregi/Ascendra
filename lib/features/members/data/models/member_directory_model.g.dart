// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_directory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberDirectoryModel _$MemberDirectoryModelFromJson(
  Map<String, dynamic> json,
) => _MemberDirectoryModel(
  profileId: json['profile_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  distributorId: json['distributor_id'] as String?,
  status: json['status'] as String,
  rank: json['rank'] as String,
  leaderName: json['leader_name'] as String?,
  meetingPercent: (json['meeting_percent'] as num).toInt(),
  taskPercent: (json['task_percent'] as num).toInt(),
  riskLevel: json['risk_level'] as String,
  isPromotionReady: json['is_promotion_ready'] as bool,
  recognitionCount: (json['recognition_count'] as num).toInt(),
);

Map<String, dynamic> _$MemberDirectoryModelToJson(
  _MemberDirectoryModel instance,
) => <String, dynamic>{
  'profile_id': instance.profileId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'avatar_url': instance.avatarUrl,
  'distributor_id': instance.distributorId,
  'status': instance.status,
  'rank': instance.rank,
  'leader_name': instance.leaderName,
  'meeting_percent': instance.meetingPercent,
  'task_percent': instance.taskPercent,
  'risk_level': instance.riskLevel,
  'is_promotion_ready': instance.isPromotionReady,
  'recognition_count': instance.recognitionCount,
};
