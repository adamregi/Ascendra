// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_directory_rpc_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberDirectoryItemRpcDto {

@JsonKey(name: 'profile_id') String get profileId;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'distributor_id') String get distributorId; String get status; String get rank;@JsonKey(name: 'parent_id') String? get parentId;@JsonKey(name: 'leader_name') String? get leaderName;@JsonKey(name: 'meeting_percent') double get meetingPercent;@JsonKey(name: 'task_percent') double get taskPercent;@JsonKey(name: 'risk_level') String get riskLevel;@JsonKey(name: 'is_promotion_ready') bool get isPromotionReady;@JsonKey(name: 'recognition_count') int get recognitionCount;
/// Create a copy of MemberDirectoryItemRpcDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDirectoryItemRpcDtoCopyWith<MemberDirectoryItemRpcDto> get copyWith => _$MemberDirectoryItemRpcDtoCopyWithImpl<MemberDirectoryItemRpcDto>(this as MemberDirectoryItemRpcDto, _$identity);

  /// Serializes this MemberDirectoryItemRpcDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDirectoryItemRpcDto&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,parentId,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryItemRpcDto(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, parentId: $parentId, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class $MemberDirectoryItemRpcDtoCopyWith<$Res>  {
  factory $MemberDirectoryItemRpcDtoCopyWith(MemberDirectoryItemRpcDto value, $Res Function(MemberDirectoryItemRpcDto) _then) = _$MemberDirectoryItemRpcDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'distributor_id') String distributorId, String status, String rank,@JsonKey(name: 'parent_id') String? parentId,@JsonKey(name: 'leader_name') String? leaderName,@JsonKey(name: 'meeting_percent') double meetingPercent,@JsonKey(name: 'task_percent') double taskPercent,@JsonKey(name: 'risk_level') String riskLevel,@JsonKey(name: 'is_promotion_ready') bool isPromotionReady,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class _$MemberDirectoryItemRpcDtoCopyWithImpl<$Res>
    implements $MemberDirectoryItemRpcDtoCopyWith<$Res> {
  _$MemberDirectoryItemRpcDtoCopyWithImpl(this._self, this._then);

  final MemberDirectoryItemRpcDto _self;
  final $Res Function(MemberDirectoryItemRpcDto) _then;

/// Create a copy of MemberDirectoryItemRpcDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? distributorId = null,Object? status = null,Object? rank = null,Object? parentId = freezed,Object? leaderName = freezed,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,Object? isPromotionReady = null,Object? recognitionCount = null,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,distributorId: null == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as double,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isPromotionReady: null == isPromotionReady ? _self.isPromotionReady : isPromotionReady // ignore: cast_nullable_to_non_nullable
as bool,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberDirectoryItemRpcDto].
extension MemberDirectoryItemRpcDtoPatterns on MemberDirectoryItemRpcDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDirectoryItemRpcDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDirectoryItemRpcDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDirectoryItemRpcDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String distributorId,  String status,  String rank, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto() when $default != null:
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.parentId,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String distributorId,  String status,  String rank, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto():
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.parentId,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String distributorId,  String status,  String rank, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryItemRpcDto() when $default != null:
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.parentId,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberDirectoryItemRpcDto implements MemberDirectoryItemRpcDto {
  const _MemberDirectoryItemRpcDto({@JsonKey(name: 'profile_id') required this.profileId, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'distributor_id') required this.distributorId, required this.status, required this.rank, @JsonKey(name: 'parent_id') this.parentId, @JsonKey(name: 'leader_name') this.leaderName, @JsonKey(name: 'meeting_percent') required this.meetingPercent, @JsonKey(name: 'task_percent') required this.taskPercent, @JsonKey(name: 'risk_level') required this.riskLevel, @JsonKey(name: 'is_promotion_ready') required this.isPromotionReady, @JsonKey(name: 'recognition_count') required this.recognitionCount});
  factory _MemberDirectoryItemRpcDto.fromJson(Map<String, dynamic> json) => _$MemberDirectoryItemRpcDtoFromJson(json);

@override@JsonKey(name: 'profile_id') final  String profileId;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'distributor_id') final  String distributorId;
@override final  String status;
@override final  String rank;
@override@JsonKey(name: 'parent_id') final  String? parentId;
@override@JsonKey(name: 'leader_name') final  String? leaderName;
@override@JsonKey(name: 'meeting_percent') final  double meetingPercent;
@override@JsonKey(name: 'task_percent') final  double taskPercent;
@override@JsonKey(name: 'risk_level') final  String riskLevel;
@override@JsonKey(name: 'is_promotion_ready') final  bool isPromotionReady;
@override@JsonKey(name: 'recognition_count') final  int recognitionCount;

/// Create a copy of MemberDirectoryItemRpcDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDirectoryItemRpcDtoCopyWith<_MemberDirectoryItemRpcDto> get copyWith => __$MemberDirectoryItemRpcDtoCopyWithImpl<_MemberDirectoryItemRpcDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberDirectoryItemRpcDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDirectoryItemRpcDto&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,parentId,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryItemRpcDto(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, parentId: $parentId, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class _$MemberDirectoryItemRpcDtoCopyWith<$Res> implements $MemberDirectoryItemRpcDtoCopyWith<$Res> {
  factory _$MemberDirectoryItemRpcDtoCopyWith(_MemberDirectoryItemRpcDto value, $Res Function(_MemberDirectoryItemRpcDto) _then) = __$MemberDirectoryItemRpcDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'distributor_id') String distributorId, String status, String rank,@JsonKey(name: 'parent_id') String? parentId,@JsonKey(name: 'leader_name') String? leaderName,@JsonKey(name: 'meeting_percent') double meetingPercent,@JsonKey(name: 'task_percent') double taskPercent,@JsonKey(name: 'risk_level') String riskLevel,@JsonKey(name: 'is_promotion_ready') bool isPromotionReady,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class __$MemberDirectoryItemRpcDtoCopyWithImpl<$Res>
    implements _$MemberDirectoryItemRpcDtoCopyWith<$Res> {
  __$MemberDirectoryItemRpcDtoCopyWithImpl(this._self, this._then);

  final _MemberDirectoryItemRpcDto _self;
  final $Res Function(_MemberDirectoryItemRpcDto) _then;

/// Create a copy of MemberDirectoryItemRpcDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? distributorId = null,Object? status = null,Object? rank = null,Object? parentId = freezed,Object? leaderName = freezed,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,Object? isPromotionReady = null,Object? recognitionCount = null,}) {
  return _then(_MemberDirectoryItemRpcDto(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,distributorId: null == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as double,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isPromotionReady: null == isPromotionReady ? _self.isPromotionReady : isPromotionReady // ignore: cast_nullable_to_non_nullable
as bool,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
