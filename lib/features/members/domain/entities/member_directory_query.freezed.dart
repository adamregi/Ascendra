// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_directory_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberDirectoryFilter {

 String? get searchQuery; String? get status; String? get leaderId; bool? get promotionReady; bool? get highRisk;
/// Create a copy of MemberDirectoryFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDirectoryFilterCopyWith<MemberDirectoryFilter> get copyWith => _$MemberDirectoryFilterCopyWithImpl<MemberDirectoryFilter>(this as MemberDirectoryFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDirectoryFilter&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaderId, leaderId) || other.leaderId == leaderId)&&(identical(other.promotionReady, promotionReady) || other.promotionReady == promotionReady)&&(identical(other.highRisk, highRisk) || other.highRisk == highRisk));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,status,leaderId,promotionReady,highRisk);

@override
String toString() {
  return 'MemberDirectoryFilter(searchQuery: $searchQuery, status: $status, leaderId: $leaderId, promotionReady: $promotionReady, highRisk: $highRisk)';
}


}

/// @nodoc
abstract mixin class $MemberDirectoryFilterCopyWith<$Res>  {
  factory $MemberDirectoryFilterCopyWith(MemberDirectoryFilter value, $Res Function(MemberDirectoryFilter) _then) = _$MemberDirectoryFilterCopyWithImpl;
@useResult
$Res call({
 String? searchQuery, String? status, String? leaderId, bool? promotionReady, bool? highRisk
});




}
/// @nodoc
class _$MemberDirectoryFilterCopyWithImpl<$Res>
    implements $MemberDirectoryFilterCopyWith<$Res> {
  _$MemberDirectoryFilterCopyWithImpl(this._self, this._then);

  final MemberDirectoryFilter _self;
  final $Res Function(MemberDirectoryFilter) _then;

/// Create a copy of MemberDirectoryFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = freezed,Object? status = freezed,Object? leaderId = freezed,Object? promotionReady = freezed,Object? highRisk = freezed,}) {
  return _then(_self.copyWith(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,leaderId: freezed == leaderId ? _self.leaderId : leaderId // ignore: cast_nullable_to_non_nullable
as String?,promotionReady: freezed == promotionReady ? _self.promotionReady : promotionReady // ignore: cast_nullable_to_non_nullable
as bool?,highRisk: freezed == highRisk ? _self.highRisk : highRisk // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberDirectoryFilter].
extension MemberDirectoryFilterPatterns on MemberDirectoryFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDirectoryFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDirectoryFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDirectoryFilter value)  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDirectoryFilter value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? searchQuery,  String? status,  String? leaderId,  bool? promotionReady,  bool? highRisk)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDirectoryFilter() when $default != null:
return $default(_that.searchQuery,_that.status,_that.leaderId,_that.promotionReady,_that.highRisk);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? searchQuery,  String? status,  String? leaderId,  bool? promotionReady,  bool? highRisk)  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryFilter():
return $default(_that.searchQuery,_that.status,_that.leaderId,_that.promotionReady,_that.highRisk);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? searchQuery,  String? status,  String? leaderId,  bool? promotionReady,  bool? highRisk)?  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryFilter() when $default != null:
return $default(_that.searchQuery,_that.status,_that.leaderId,_that.promotionReady,_that.highRisk);case _:
  return null;

}
}

}

/// @nodoc


class _MemberDirectoryFilter implements MemberDirectoryFilter {
  const _MemberDirectoryFilter({this.searchQuery, this.status, this.leaderId, this.promotionReady, this.highRisk});
  

@override final  String? searchQuery;
@override final  String? status;
@override final  String? leaderId;
@override final  bool? promotionReady;
@override final  bool? highRisk;

/// Create a copy of MemberDirectoryFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDirectoryFilterCopyWith<_MemberDirectoryFilter> get copyWith => __$MemberDirectoryFilterCopyWithImpl<_MemberDirectoryFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDirectoryFilter&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaderId, leaderId) || other.leaderId == leaderId)&&(identical(other.promotionReady, promotionReady) || other.promotionReady == promotionReady)&&(identical(other.highRisk, highRisk) || other.highRisk == highRisk));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,status,leaderId,promotionReady,highRisk);

@override
String toString() {
  return 'MemberDirectoryFilter(searchQuery: $searchQuery, status: $status, leaderId: $leaderId, promotionReady: $promotionReady, highRisk: $highRisk)';
}


}

/// @nodoc
abstract mixin class _$MemberDirectoryFilterCopyWith<$Res> implements $MemberDirectoryFilterCopyWith<$Res> {
  factory _$MemberDirectoryFilterCopyWith(_MemberDirectoryFilter value, $Res Function(_MemberDirectoryFilter) _then) = __$MemberDirectoryFilterCopyWithImpl;
@override @useResult
$Res call({
 String? searchQuery, String? status, String? leaderId, bool? promotionReady, bool? highRisk
});




}
/// @nodoc
class __$MemberDirectoryFilterCopyWithImpl<$Res>
    implements _$MemberDirectoryFilterCopyWith<$Res> {
  __$MemberDirectoryFilterCopyWithImpl(this._self, this._then);

  final _MemberDirectoryFilter _self;
  final $Res Function(_MemberDirectoryFilter) _then;

/// Create a copy of MemberDirectoryFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = freezed,Object? status = freezed,Object? leaderId = freezed,Object? promotionReady = freezed,Object? highRisk = freezed,}) {
  return _then(_MemberDirectoryFilter(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,leaderId: freezed == leaderId ? _self.leaderId : leaderId // ignore: cast_nullable_to_non_nullable
as String?,promotionReady: freezed == promotionReady ? _self.promotionReady : promotionReady // ignore: cast_nullable_to_non_nullable
as bool?,highRisk: freezed == highRisk ? _self.highRisk : highRisk // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$MemberDirectoryQueryParams {

 MemberDirectoryFilter get filter; String? get cursor; int get limit;
/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberDirectoryQueryParamsCopyWith<MemberDirectoryQueryParams> get copyWith => _$MemberDirectoryQueryParamsCopyWithImpl<MemberDirectoryQueryParams>(this as MemberDirectoryQueryParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberDirectoryQueryParams&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,filter,cursor,limit);

@override
String toString() {
  return 'MemberDirectoryQueryParams(filter: $filter, cursor: $cursor, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $MemberDirectoryQueryParamsCopyWith<$Res>  {
  factory $MemberDirectoryQueryParamsCopyWith(MemberDirectoryQueryParams value, $Res Function(MemberDirectoryQueryParams) _then) = _$MemberDirectoryQueryParamsCopyWithImpl;
@useResult
$Res call({
 MemberDirectoryFilter filter, String? cursor, int limit
});


$MemberDirectoryFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$MemberDirectoryQueryParamsCopyWithImpl<$Res>
    implements $MemberDirectoryQueryParamsCopyWith<$Res> {
  _$MemberDirectoryQueryParamsCopyWithImpl(this._self, this._then);

  final MemberDirectoryQueryParams _self;
  final $Res Function(MemberDirectoryQueryParams) _then;

/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filter = null,Object? cursor = freezed,Object? limit = null,}) {
  return _then(_self.copyWith(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as MemberDirectoryFilter,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberDirectoryFilterCopyWith<$Res> get filter {
  
  return $MemberDirectoryFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberDirectoryQueryParams].
extension MemberDirectoryQueryParamsPatterns on MemberDirectoryQueryParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberDirectoryQueryParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberDirectoryQueryParams value)  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberDirectoryQueryParams value)?  $default,){
final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberDirectoryFilter filter,  String? cursor,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams() when $default != null:
return $default(_that.filter,_that.cursor,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberDirectoryFilter filter,  String? cursor,  int limit)  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams():
return $default(_that.filter,_that.cursor,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberDirectoryFilter filter,  String? cursor,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _MemberDirectoryQueryParams() when $default != null:
return $default(_that.filter,_that.cursor,_that.limit);case _:
  return null;

}
}

}

/// @nodoc


class _MemberDirectoryQueryParams implements MemberDirectoryQueryParams {
  const _MemberDirectoryQueryParams({required this.filter, this.cursor, this.limit = 50});
  

@override final  MemberDirectoryFilter filter;
@override final  String? cursor;
@override@JsonKey() final  int limit;

/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberDirectoryQueryParamsCopyWith<_MemberDirectoryQueryParams> get copyWith => __$MemberDirectoryQueryParamsCopyWithImpl<_MemberDirectoryQueryParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberDirectoryQueryParams&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,filter,cursor,limit);

@override
String toString() {
  return 'MemberDirectoryQueryParams(filter: $filter, cursor: $cursor, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$MemberDirectoryQueryParamsCopyWith<$Res> implements $MemberDirectoryQueryParamsCopyWith<$Res> {
  factory _$MemberDirectoryQueryParamsCopyWith(_MemberDirectoryQueryParams value, $Res Function(_MemberDirectoryQueryParams) _then) = __$MemberDirectoryQueryParamsCopyWithImpl;
@override @useResult
$Res call({
 MemberDirectoryFilter filter, String? cursor, int limit
});


@override $MemberDirectoryFilterCopyWith<$Res> get filter;

}
/// @nodoc
class __$MemberDirectoryQueryParamsCopyWithImpl<$Res>
    implements _$MemberDirectoryQueryParamsCopyWith<$Res> {
  __$MemberDirectoryQueryParamsCopyWithImpl(this._self, this._then);

  final _MemberDirectoryQueryParams _self;
  final $Res Function(_MemberDirectoryQueryParams) _then;

/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filter = null,Object? cursor = freezed,Object? limit = null,}) {
  return _then(_MemberDirectoryQueryParams(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as MemberDirectoryFilter,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MemberDirectoryQueryParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberDirectoryFilterCopyWith<$Res> get filter {
  
  return $MemberDirectoryFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on
