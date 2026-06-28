// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_directory_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberDirectoryItem {

 String get profileId; String get firstName; String get lastName; String? get avatarUrl; String get distributorId; String get status; String get rank; String? get parentId; String? get leaderName; double get meetingPercent; double get taskPercent; String get riskLevel; bool get isPromotionReady; int get recognitionCount;
/// Create a copy of MemberDirectoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDirectoryItemCopyWith<MemberDirectoryItem> get copyWith => _$MemberDirectoryItemCopyWithImpl<MemberDirectoryItem>(this as MemberDirectoryItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDirectoryItem&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,parentId,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryItem(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, parentId: $parentId, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class $MemberDirectoryItemCopyWith<$Res>  {
  factory $MemberDirectoryItemCopyWith(MemberDirectoryItem value, $Res Function(MemberDirectoryItem) _then) = _$MemberDirectoryItemCopyWithImpl;
@useResult
$Res call({
 String profileId, String firstName, String lastName, String? avatarUrl, String distributorId, String status, String rank, String? parentId, String? leaderName, double meetingPercent, double taskPercent, String riskLevel, bool isPromotionReady, int recognitionCount
});




}
/// @nodoc
class _$MemberDirectoryItemCopyWithImpl<$Res>
    implements $MemberDirectoryItemCopyWith<$Res> {
  _$MemberDirectoryItemCopyWithImpl(this._self, this._then);

  final MemberDirectoryItem _self;
  final $Res Function(MemberDirectoryItem) _then;

/// Create a copy of MemberDirectoryItem
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


/// Adds pattern-matching-related methods to [MemberDirectoryItem].
extension MemberDirectoryItemPatterns on MemberDirectoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDirectoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDirectoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDirectoryItem value)  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDirectoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  String firstName,  String lastName,  String? avatarUrl,  String distributorId,  String status,  String rank,  String? parentId,  String? leaderName,  double meetingPercent,  double taskPercent,  String riskLevel,  bool isPromotionReady,  int recognitionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDirectoryItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  String firstName,  String lastName,  String? avatarUrl,  String distributorId,  String status,  String rank,  String? parentId,  String? leaderName,  double meetingPercent,  double taskPercent,  String riskLevel,  bool isPromotionReady,  int recognitionCount)  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  String firstName,  String lastName,  String? avatarUrl,  String distributorId,  String status,  String rank,  String? parentId,  String? leaderName,  double meetingPercent,  double taskPercent,  String riskLevel,  bool isPromotionReady,  int recognitionCount)?  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryItem() when $default != null:
return $default(_that.profileId,_that.firstName,_that.lastName,_that.avatarUrl,_that.distributorId,_that.status,_that.rank,_that.parentId,_that.leaderName,_that.meetingPercent,_that.taskPercent,_that.riskLevel,_that.isPromotionReady,_that.recognitionCount);case _:
  return null;

}
}

}

/// @nodoc


class _MemberDirectoryItem implements MemberDirectoryItem {
  const _MemberDirectoryItem({required this.profileId, required this.firstName, required this.lastName, this.avatarUrl, required this.distributorId, required this.status, required this.rank, this.parentId, this.leaderName, required this.meetingPercent, required this.taskPercent, required this.riskLevel, required this.isPromotionReady, required this.recognitionCount});
  

@override final  String profileId;
@override final  String firstName;
@override final  String lastName;
@override final  String? avatarUrl;
@override final  String distributorId;
@override final  String status;
@override final  String rank;
@override final  String? parentId;
@override final  String? leaderName;
@override final  double meetingPercent;
@override final  double taskPercent;
@override final  String riskLevel;
@override final  bool isPromotionReady;
@override final  int recognitionCount;

/// Create a copy of MemberDirectoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDirectoryItemCopyWith<_MemberDirectoryItem> get copyWith => __$MemberDirectoryItemCopyWithImpl<_MemberDirectoryItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDirectoryItem&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isPromotionReady, isPromotionReady) || other.isPromotionReady == isPromotionReady)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,firstName,lastName,avatarUrl,distributorId,status,rank,parentId,leaderName,meetingPercent,taskPercent,riskLevel,isPromotionReady,recognitionCount);

@override
String toString() {
  return 'MemberDirectoryItem(profileId: $profileId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, distributorId: $distributorId, status: $status, rank: $rank, parentId: $parentId, leaderName: $leaderName, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel, isPromotionReady: $isPromotionReady, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class _$MemberDirectoryItemCopyWith<$Res> implements $MemberDirectoryItemCopyWith<$Res> {
  factory _$MemberDirectoryItemCopyWith(_MemberDirectoryItem value, $Res Function(_MemberDirectoryItem) _then) = __$MemberDirectoryItemCopyWithImpl;
@override @useResult
$Res call({
 String profileId, String firstName, String lastName, String? avatarUrl, String distributorId, String status, String rank, String? parentId, String? leaderName, double meetingPercent, double taskPercent, String riskLevel, bool isPromotionReady, int recognitionCount
});




}
/// @nodoc
class __$MemberDirectoryItemCopyWithImpl<$Res>
    implements _$MemberDirectoryItemCopyWith<$Res> {
  __$MemberDirectoryItemCopyWithImpl(this._self, this._then);

  final _MemberDirectoryItem _self;
  final $Res Function(_MemberDirectoryItem) _then;

/// Create a copy of MemberDirectoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? distributorId = null,Object? status = null,Object? rank = null,Object? parentId = freezed,Object? leaderName = freezed,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,Object? isPromotionReady = null,Object? recognitionCount = null,}) {
  return _then(_MemberDirectoryItem(
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
