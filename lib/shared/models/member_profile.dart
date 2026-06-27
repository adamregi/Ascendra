import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_profile.freezed.dart';
part 'member_profile.g.dart';

@freezed
abstract class MemberProfile with _$MemberProfile {
  const factory MemberProfile({
    required String id,
    @JsonKey(name: 'auth_user_id') String? authUserId,
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'full_name') required String fullName,
    required String role,
    required String status,
    @JsonKey(name: 'distributor_id') String? distributorId,
    String? email,
    String? phone,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _MemberProfile;

  factory MemberProfile.fromJson(Map<String, dynamic> json) => _$MemberProfileFromJson(json);
}
