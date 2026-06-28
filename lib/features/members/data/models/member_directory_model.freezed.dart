// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_directory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberDirectoryModel {

@JsonKey(name: 'profile_id') String get profileId;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'distributor_id') String? get distributorId; String get status; String get rank;@JsonKey(name: 'leader_name') String? get leaderName;@JsonKey(name: 'meeting_percent') int get meetingPercent;@JsonKey(name: 'task_percent') int get taskPercent;@JsonKey(name: 'risk_level') String get riskLevel;@JsonKey(name: 'is_promotion_ready') bool get isPromotionReady;@JsonKey(name: 'recognition_count') int get recognitionCount;
/// Create a copy of MemberDirectoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDirectoryModelCopyWith<MemberDirectoryModel> get copyWith => _$MemberDirectoryModelCopyWithImpl<MemberDirectoryModel>(this as MemberDirectoryModel, _$identity);

  /// Serializes this MemberDirectoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDirectoryModel&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryModel(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class $MemberDirectoryModelCopyWith<$Res>  {
  factory $MemberDirectoryModelCopyWith(MemberDirectoryModel value, $Res Function(MemberDirectoryModel) _then) = _$MemberDirectoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'distributor_id') String? distributorId, String status, String rank,@JsonKey(name: 'leader_name') String? leaderName,@JsonKey(name: 'meeting_percent') int meetingPercent,@JsonKey(name: 'task_percent') int taskPercent,@JsonKey(name: 'risk_level') String riskLevel,@JsonKey(name: 'is_promotion_ready') bool isPromotionReady,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class _$MemberDirectoryModelCopyWithImpl<$Res>
    implements $MemberDirectoryModelCopyWith<$Res> {
  _$MemberDirectoryModelCopyWithImpl(this._self, this._then);

  final MemberDirectoryModel _self;
  final $Res Function(MemberDirectoryModel) _then;

/// Create a copy of MemberDirectoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? distributorId = freezed,Object? status = null,Object? rank = null,Object? leaderName = freezed,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,Object? isPromotionReady = null,Object? recognitionCount = null,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,distributorId: freezed == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as int,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isPromotionReady: null == isPromotionReady ? _self.isPromotionReady : isPromotionReady // ignore: cast_nullable_to_non_nullable
as bool,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberDirectoryModel].
extension MemberDirectoryModelPatterns on MemberDirectoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDirectoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDirectoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDirectoryModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDirectoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String? distributorId,  String status,  String rank, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDirectoryModel() when $default != null:
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String? distributorId,  String status,  String rank, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryModel():
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'distributor_id')  String? distributorId,  String status,  String rank, @JsonKey(name: 'leader_name')  String? leaderName, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel, @JsonKey(name: 'is_promotion_ready')  bool isPromotionReady, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryModel() when $default != null:
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberDirectoryModel implements MemberDirectoryModel {
  const _MemberDirectoryModel({@JsonKey(name: 'profile_id') required this.profileId, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'distributor_id') this.distributorId, required this.status, required this.rank, @JsonKey(name: 'leader_name') this.leaderName, @JsonKey(name: 'meeting_percent') required this.meetingPercent, @JsonKey(name: 'task_percent') required this.taskPercent, @JsonKey(name: 'risk_level') required this.riskLevel, @JsonKey(name: 'is_promotion_ready') required this.isPromotionReady, @JsonKey(name: 'recognition_count') required this.recognitionCount});
  factory _MemberDirectoryModel.fromJson(Map<String, dynamic> json) => _$MemberDirectoryModelFromJson(json);

@override@JsonKey(name: 'profile_id') final  String profileId;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'distributor_id') final  String? distributorId;
@override final  String status;
@override final  String rank;
@override@JsonKey(name: 'leader_name') final  String? leaderName;
@override@JsonKey(name: 'meeting_percent') final  int meetingPercent;
@override@JsonKey(name: 'task_percent') final  int taskPercent;
@override@JsonKey(name: 'risk_level') final  String riskLevel;
@override@JsonKey(name: 'is_promotion_ready') final  bool isPromotionReady;
@override@JsonKey(name: 'recognition_count') final  int recognitionCount;

/// Create a copy of MemberDirectoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDirectoryModelCopyWith<_MemberDirectoryModel> get copyWith => __$MemberDirectoryModelCopyWithImpl<_MemberDirectoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberDirectoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDirectoryModel&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryModel(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class _$MemberDirectoryModelCopyWith<$Res> implements $MemberDirectoryModelCopyWith<$Res> {
  factory _$MemberDirectoryModelCopyWith(_MemberDirectoryModel value, $Res Function(_MemberDirectoryModel) _then) = __$MemberDirectoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'distributor_id') String? distributorId, String status, String rank,@JsonKey(name: 'leader_name') String? leaderName,@JsonKey(name: 'meeting_percent') int meetingPercent,@JsonKey(name: 'task_percent') int taskPercent,@JsonKey(name: 'risk_level') String riskLevel,@JsonKey(name: 'is_promotion_ready') bool isPromotionReady,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class __$MemberDirectoryModelCopyWithImpl<$Res>
    implements _$MemberDirectoryModelCopyWith<$Res> {
  __$MemberDirectoryModelCopyWithImpl(this._self, this._then);

  final _MemberDirectoryModel _self;
  final $Res Function(_MemberDirectoryModel) _then;

/// Create a copy of MemberDirectoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? distributorId = freezed,Object? status = null,Object? rank = null,Object? leaderName = freezed,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,Object? isPromotionReady = null,Object? recognitionCount = null,}) {
  return _then(_MemberDirectoryModel(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,distributorId: freezed == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as int,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isPromotionReady: null == isPromotionReady ? _self.isPromotionReady : isPromotionReady // ignore: cast_nullable_to_non_nullable
as bool,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
