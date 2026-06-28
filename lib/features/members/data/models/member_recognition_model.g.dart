// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_recognition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberRecognitionModel _$MemberRecognitionModelFromJson(
  Map<String, dynamic> json,
) => _MemberRecognitionModel(
  name: json['name'] as String,
  description: json['description'] as String,
  earnedDate: DateTime.parse(json['earned_date'] as String),
  category: json['category'] as String,
  icon: json['icon'] as String,
  level: (json['level'] as num).toInt(),
  points: (json['points'] as num).toInt(),
);

Map<String, dynamic> _$MemberRecognitionModelToJson(
  _MemberRecognitionModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'earned_date': instance.earnedDate.toIso8601String(),
  'category': instance.category,
  'icon': instance.icon,
  'level': instance.level,
  'points': instance.points,
};
