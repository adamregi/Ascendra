// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberProfile {

 String get id;@JsonKey(name: 'auth_user_id') String? get authUserId;@JsonKey(name: 'company_id') String get companyId;@JsonKey(name: 'full_name') String get fullName; String get role; String get status;@JsonKey(name: 'distributor_id') String? get distributorId; String? get email; String? get phone;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileCopyWith<MemberProfile> get copyWith => _$MemberProfileCopyWithImpl<MemberProfile>(this as MemberProfile, _$identity);

  /// Serializes this MemberProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.authUserId, authUserId) || other.authUserId == authUserId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authUserId,companyId,fullName,role,status,distributorId,email,phone,createdAt);

@override
String toString() {
  return 'MemberProfile(id: $id, authUserId: $authUserId, companyId: $companyId, fullName: $fullName, role: $role, status: $status, distributorId: $distributorId, email: $email, phone: $phone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MemberProfileCopyWith<$Res>  {
  factory $MemberProfileCopyWith(MemberProfile value, $Res Function(MemberProfile) _then) = _$MemberProfileCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'auth_user_id') String? authUserId,@JsonKey(name: 'company_id') String companyId,@JsonKey(name: 'full_name') String fullName, String role, String status,@JsonKey(name: 'distributor_id') String? distributorId, String? email, String? phone,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$MemberProfileCopyWithImpl<$Res>
    implements $MemberProfileCopyWith<$Res> {
  _$MemberProfileCopyWithImpl(this._self, this._then);

  final MemberProfile _self;
  final $Res Function(MemberProfile) _then;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authUserId = freezed,Object? companyId = null,Object? fullName = null,Object? role = null,Object? status = null,Object? distributorId = freezed,Object? email = freezed,Object? phone = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authUserId: freezed == authUserId ? _self.authUserId : authUserId // ignore: cast_nullable_to_non_nullable
as String?,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,distributorId: freezed == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfile].
extension MemberProfilePatterns on MemberProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfile value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfile value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'auth_user_id')  String? authUserId, @JsonKey(name: 'company_id')  String companyId, @JsonKey(name: 'full_name')  String fullName,  String role,  String status, @JsonKey(name: 'distributor_id')  String? distributorId,  String? email,  String? phone, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
return $default(_that.id,_that.authUserId,_that.companyId,_that.fullName,_that.role,_that.status,_that.distributorId,_that.email,_that.phone,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'auth_user_id')  String? authUserId, @JsonKey(name: 'company_id')  String companyId, @JsonKey(name: 'full_name')  String fullName,  String role,  String status, @JsonKey(name: 'distributor_id')  String? distributorId,  String? email,  String? phone, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MemberProfile():
return $default(_that.id,_that.authUserId,_that.companyId,_that.fullName,_that.role,_that.status,_that.distributorId,_that.email,_that.phone,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'auth_user_id')  String? authUserId, @JsonKey(name: 'company_id')  String companyId, @JsonKey(name: 'full_name')  String fullName,  String role,  String status, @JsonKey(name: 'distributor_id')  String? distributorId,  String? email,  String? phone, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
return $default(_that.id,_that.authUserId,_that.companyId,_that.fullName,_that.role,_that.status,_that.distributorId,_that.email,_that.phone,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfile implements MemberProfile {
  const _MemberProfile({required this.id, @JsonKey(name: 'auth_user_id') this.authUserId, @JsonKey(name: 'company_id') required this.companyId, @JsonKey(name: 'full_name') required this.fullName, required this.role, required this.status, @JsonKey(name: 'distributor_id') this.distributorId, this.email, this.phone, @JsonKey(name: 'created_at') this.createdAt});
  factory _MemberProfile.fromJson(Map<String, dynamic> json) => _$MemberProfileFromJson(json);

@override final  String id;
@override@JsonKey(name: 'auth_user_id') final  String? authUserId;
@override@JsonKey(name: 'company_id') final  String companyId;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String role;
@override final  String status;
@override@JsonKey(name: 'distributor_id') final  String? distributorId;
@override final  String? email;
@override final  String? phone;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileCopyWith<_MemberProfile> get copyWith => __$MemberProfileCopyWithImpl<_MemberProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.authUserId, authUserId) || other.authUserId == authUserId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authUserId,companyId,fullName,role,status,distributorId,email,phone,createdAt);

@override
String toString() {
  return 'MemberProfile(id: $id, authUserId: $authUserId, companyId: $companyId, fullName: $fullName, role: $role, status: $status, distributorId: $distributorId, email: $email, phone: $phone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileCopyWith<$Res> implements $MemberProfileCopyWith<$Res> {
  factory _$MemberProfileCopyWith(_MemberProfile value, $Res Function(_MemberProfile) _then) = __$MemberProfileCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'auth_user_id') String? authUserId,@JsonKey(name: 'company_id') String companyId,@JsonKey(name: 'full_name') String fullName, String role, String status,@JsonKey(name: 'distributor_id') String? distributorId, String? email, String? phone,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$MemberProfileCopyWithImpl<$Res>
    implements _$MemberProfileCopyWith<$Res> {
  __$MemberProfileCopyWithImpl(this._self, this._then);

  final _MemberProfile _self;
  final $Res Function(_MemberProfile) _then;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authUserId = freezed,Object? companyId = null,Object? fullName = null,Object? role = null,Object? status = null,Object? distributorId = freezed,Object? email = freezed,Object? phone = freezed,Object? createdAt = freezed,}) {
  return _then(_MemberProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authUserId: freezed == authUserId ? _self.authUserId : authUserId // ignore: cast_nullable_to_non_nullable
as String?,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,distributorId: freezed == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
