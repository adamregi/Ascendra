// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberProfile _$MemberProfileFromJson(Map<String, dynamic> json) =>
    _MemberProfile(
      id: json['id'] as String,
      authUserId: json['auth_user_id'] as String?,
      companyId: json['company_id'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      distributorId: json['distributor_id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MemberProfileToJson(_MemberProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auth_user_id': instance.authUserId,
      'company_id': instance.companyId,
      'full_name': instance.fullName,
      'role': instance.role,
      'status': instance.status,
      'distributor_id': instance.distributorId,
      'email': instance.email,
      'phone': instance.phone,
      'created_at': instance.createdAt,
    };
