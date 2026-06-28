// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_profile_rpc_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberProfileRpcDto {

 int get version;@JsonKey(name: 'generated_at') DateTime get generatedAt; MemberProfileHeroDto get hero; MemberProfileOverviewDto get overview; MemberProfileComplianceDto get compliance; List<MemberProfileTimelineDto> get timeline; List<MemberProfileRecognitionDto> get recognition; MemberProfileAnalyticsDto get analytics;
/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileRpcDtoCopyWith<MemberProfileRpcDto> get copyWith => _$MemberProfileRpcDtoCopyWithImpl<MemberProfileRpcDto>(this as MemberProfileRpcDto, _$identity);

  /// Serializes this MemberProfileRpcDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileRpcDto&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.recognition, recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generatedAt,hero,overview,compliance,const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(recognition),analytics);

@override
String toString() {
  return 'MemberProfileRpcDto(version: $version, generatedAt: $generatedAt, hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class $MemberProfileRpcDtoCopyWith<$Res>  {
  factory $MemberProfileRpcDtoCopyWith(MemberProfileRpcDto value, $Res Function(MemberProfileRpcDto) _then) = _$MemberProfileRpcDtoCopyWithImpl;
@useResult
$Res call({
 int version,@JsonKey(name: 'generated_at') DateTime generatedAt, MemberProfileHeroDto hero, MemberProfileOverviewDto overview, MemberProfileComplianceDto compliance, List<MemberProfileTimelineDto> timeline, List<MemberProfileRecognitionDto> recognition, MemberProfileAnalyticsDto analytics
});


$MemberProfileHeroDtoCopyWith<$Res> get hero;$MemberProfileOverviewDtoCopyWith<$Res> get overview;$MemberProfileComplianceDtoCopyWith<$Res> get compliance;$MemberProfileAnalyticsDtoCopyWith<$Res> get analytics;

}
/// @nodoc
class _$MemberProfileRpcDtoCopyWithImpl<$Res>
    implements $MemberProfileRpcDtoCopyWith<$Res> {
  _$MemberProfileRpcDtoCopyWithImpl(this._self, this._then);

  final MemberProfileRpcDto _self;
  final $Res Function(MemberProfileRpcDto) _then;

/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? generatedAt = null,Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberProfileHeroDto,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberProfileOverviewDto,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberProfileComplianceDto,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberProfileTimelineDto>,recognition: null == recognition ? _self.recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberProfileRecognitionDto>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberProfileAnalyticsDto,
  ));
}
/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileHeroDtoCopyWith<$Res> get hero {
  
  return $MemberProfileHeroDtoCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileOverviewDtoCopyWith<$Res> get overview {
  
  return $MemberProfileOverviewDtoCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileComplianceDtoCopyWith<$Res> get compliance {
  
  return $MemberProfileComplianceDtoCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileAnalyticsDtoCopyWith<$Res> get analytics {
  
  return $MemberProfileAnalyticsDtoCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberProfileRpcDto].
extension MemberProfileRpcDtoPatterns on MemberProfileRpcDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileRpcDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileRpcDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileRpcDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileRpcDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileRpcDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileRpcDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberProfileHeroDto hero,  MemberProfileOverviewDto overview,  MemberProfileComplianceDto compliance,  List<MemberProfileTimelineDto> timeline,  List<MemberProfileRecognitionDto> recognition,  MemberProfileAnalyticsDto analytics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileRpcDto() when $default != null:
return $default(_that.version,_that.generatedAt,_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberProfileHeroDto hero,  MemberProfileOverviewDto overview,  MemberProfileComplianceDto compliance,  List<MemberProfileTimelineDto> timeline,  List<MemberProfileRecognitionDto> recognition,  MemberProfileAnalyticsDto analytics)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileRpcDto():
return $default(_that.version,_that.generatedAt,_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberProfileHeroDto hero,  MemberProfileOverviewDto overview,  MemberProfileComplianceDto compliance,  List<MemberProfileTimelineDto> timeline,  List<MemberProfileRecognitionDto> recognition,  MemberProfileAnalyticsDto analytics)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileRpcDto() when $default != null:
return $default(_that.version,_that.generatedAt,_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileRpcDto implements MemberProfileRpcDto {
  const _MemberProfileRpcDto({required this.version, @JsonKey(name: 'generated_at') required this.generatedAt, required this.hero, required this.overview, required this.compliance, required final  List<MemberProfileTimelineDto> timeline, required final  List<MemberProfileRecognitionDto> recognition, required this.analytics}): _timeline = timeline,_recognition = recognition;
  factory _MemberProfileRpcDto.fromJson(Map<String, dynamic> json) => _$MemberProfileRpcDtoFromJson(json);

@override final  int version;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
@override final  MemberProfileHeroDto hero;
@override final  MemberProfileOverviewDto overview;
@override final  MemberProfileComplianceDto compliance;
 final  List<MemberProfileTimelineDto> _timeline;
@override List<MemberProfileTimelineDto> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<MemberProfileRecognitionDto> _recognition;
@override List<MemberProfileRecognitionDto> get recognition {
  if (_recognition is EqualUnmodifiableListView) return _recognition;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognition);
}

@override final  MemberProfileAnalyticsDto analytics;

/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileRpcDtoCopyWith<_MemberProfileRpcDto> get copyWith => __$MemberProfileRpcDtoCopyWithImpl<_MemberProfileRpcDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileRpcDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileRpcDto&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._recognition, _recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generatedAt,hero,overview,compliance,const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_recognition),analytics);

@override
String toString() {
  return 'MemberProfileRpcDto(version: $version, generatedAt: $generatedAt, hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileRpcDtoCopyWith<$Res> implements $MemberProfileRpcDtoCopyWith<$Res> {
  factory _$MemberProfileRpcDtoCopyWith(_MemberProfileRpcDto value, $Res Function(_MemberProfileRpcDto) _then) = __$MemberProfileRpcDtoCopyWithImpl;
@override @useResult
$Res call({
 int version,@JsonKey(name: 'generated_at') DateTime generatedAt, MemberProfileHeroDto hero, MemberProfileOverviewDto overview, MemberProfileComplianceDto compliance, List<MemberProfileTimelineDto> timeline, List<MemberProfileRecognitionDto> recognition, MemberProfileAnalyticsDto analytics
});


@override $MemberProfileHeroDtoCopyWith<$Res> get hero;@override $MemberProfileOverviewDtoCopyWith<$Res> get overview;@override $MemberProfileComplianceDtoCopyWith<$Res> get compliance;@override $MemberProfileAnalyticsDtoCopyWith<$Res> get analytics;

}
/// @nodoc
class __$MemberProfileRpcDtoCopyWithImpl<$Res>
    implements _$MemberProfileRpcDtoCopyWith<$Res> {
  __$MemberProfileRpcDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileRpcDto _self;
  final $Res Function(_MemberProfileRpcDto) _then;

/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? generatedAt = null,Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_MemberProfileRpcDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberProfileHeroDto,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberProfileOverviewDto,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberProfileComplianceDto,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberProfileTimelineDto>,recognition: null == recognition ? _self._recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberProfileRecognitionDto>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberProfileAnalyticsDto,
  ));
}

/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileHeroDtoCopyWith<$Res> get hero {
  
  return $MemberProfileHeroDtoCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileOverviewDtoCopyWith<$Res> get overview {
  
  return $MemberProfileOverviewDtoCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileComplianceDtoCopyWith<$Res> get compliance {
  
  return $MemberProfileComplianceDtoCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfileRpcDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileAnalyticsDtoCopyWith<$Res> get analytics {
  
  return $MemberProfileAnalyticsDtoCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
}
}


/// @nodoc
mixin _$MemberProfileHeroDto {

@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'distributor_id') String get distributorId;@JsonKey(name: 'leader_name') String? get leaderName; String get rank; String get status;@JsonKey(name: 'joined_date') DateTime get joinedDate;@JsonKey(name: 'current_streak') int get currentStreak;
/// Create a copy of MemberProfileHeroDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileHeroDtoCopyWith<MemberProfileHeroDto> get copyWith => _$MemberProfileHeroDtoCopyWithImpl<MemberProfileHeroDto>(this as MemberProfileHeroDto, _$identity);

  /// Serializes this MemberProfileHeroDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileHeroDto&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberProfileHeroDto(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class $MemberProfileHeroDtoCopyWith<$Res>  {
  factory $MemberProfileHeroDtoCopyWith(MemberProfileHeroDto value, $Res Function(MemberProfileHeroDto) _then) = _$MemberProfileHeroDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'distributor_id') String distributorId,@JsonKey(name: 'leader_name') String? leaderName, String rank, String status,@JsonKey(name: 'joined_date') DateTime joinedDate,@JsonKey(name: 'current_streak') int currentStreak
});




}
/// @nodoc
class _$MemberProfileHeroDtoCopyWithImpl<$Res>
    implements $MemberProfileHeroDtoCopyWith<$Res> {
  _$MemberProfileHeroDtoCopyWithImpl(this._self, this._then);

  final MemberProfileHeroDto _self;
  final $Res Function(MemberProfileHeroDto) _then;

/// Create a copy of MemberProfileHeroDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avatarUrl = freezed,Object? firstName = null,Object? lastName = null,Object? distributorId = null,Object? leaderName = freezed,Object? rank = null,Object? status = null,Object? joinedDate = null,Object? currentStreak = null,}) {
  return _then(_self.copyWith(
avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,distributorId: null == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,joinedDate: null == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileHeroDto].
extension MemberProfileHeroDtoPatterns on MemberProfileHeroDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileHeroDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileHeroDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileHeroDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileHeroDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileHeroDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileHeroDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'distributor_id')  String distributorId, @JsonKey(name: 'leader_name')  String? leaderName,  String rank,  String status, @JsonKey(name: 'joined_date')  DateTime joinedDate, @JsonKey(name: 'current_streak')  int currentStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileHeroDto() when $default != null:
return $default(_that.avatarUrl,_that.firstName,_that.lastName,_that.distributorId,_that.leaderName,_that.rank,_that.status,_that.joinedDate,_that.currentStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'distributor_id')  String distributorId, @JsonKey(name: 'leader_name')  String? leaderName,  String rank,  String status, @JsonKey(name: 'joined_date')  DateTime joinedDate, @JsonKey(name: 'current_streak')  int currentStreak)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileHeroDto():
return $default(_that.avatarUrl,_that.firstName,_that.lastName,_that.distributorId,_that.leaderName,_that.rank,_that.status,_that.joinedDate,_that.currentStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'distributor_id')  String distributorId, @JsonKey(name: 'leader_name')  String? leaderName,  String rank,  String status, @JsonKey(name: 'joined_date')  DateTime joinedDate, @JsonKey(name: 'current_streak')  int currentStreak)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileHeroDto() when $default != null:
return $default(_that.avatarUrl,_that.firstName,_that.lastName,_that.distributorId,_that.leaderName,_that.rank,_that.status,_that.joinedDate,_that.currentStreak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileHeroDto implements MemberProfileHeroDto {
  const _MemberProfileHeroDto({@JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'distributor_id') required this.distributorId, @JsonKey(name: 'leader_name') this.leaderName, required this.rank, required this.status, @JsonKey(name: 'joined_date') required this.joinedDate, @JsonKey(name: 'current_streak') required this.currentStreak});
  factory _MemberProfileHeroDto.fromJson(Map<String, dynamic> json) => _$MemberProfileHeroDtoFromJson(json);

@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'distributor_id') final  String distributorId;
@override@JsonKey(name: 'leader_name') final  String? leaderName;
@override final  String rank;
@override final  String status;
@override@JsonKey(name: 'joined_date') final  DateTime joinedDate;
@override@JsonKey(name: 'current_streak') final  int currentStreak;

/// Create a copy of MemberProfileHeroDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileHeroDtoCopyWith<_MemberProfileHeroDto> get copyWith => __$MemberProfileHeroDtoCopyWithImpl<_MemberProfileHeroDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileHeroDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileHeroDto&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberProfileHeroDto(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileHeroDtoCopyWith<$Res> implements $MemberProfileHeroDtoCopyWith<$Res> {
  factory _$MemberProfileHeroDtoCopyWith(_MemberProfileHeroDto value, $Res Function(_MemberProfileHeroDto) _then) = __$MemberProfileHeroDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'distributor_id') String distributorId,@JsonKey(name: 'leader_name') String? leaderName, String rank, String status,@JsonKey(name: 'joined_date') DateTime joinedDate,@JsonKey(name: 'current_streak') int currentStreak
});




}
/// @nodoc
class __$MemberProfileHeroDtoCopyWithImpl<$Res>
    implements _$MemberProfileHeroDtoCopyWith<$Res> {
  __$MemberProfileHeroDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileHeroDto _self;
  final $Res Function(_MemberProfileHeroDto) _then;

/// Create a copy of MemberProfileHeroDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatarUrl = freezed,Object? firstName = null,Object? lastName = null,Object? distributorId = null,Object? leaderName = freezed,Object? rank = null,Object? status = null,Object? joinedDate = null,Object? currentStreak = null,}) {
  return _then(_MemberProfileHeroDto(
avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,distributorId: null == distributorId ? _self.distributorId : distributorId // ignore: cast_nullable_to_non_nullable
as String,leaderName: freezed == leaderName ? _self.leaderName : leaderName // ignore: cast_nullable_to_non_nullable
as String?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,joinedDate: null == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MemberProfileOverviewDto {

@JsonKey(name: 'leadership_score') int get leadershipScore;@JsonKey(name: 'recognition_count') int get recognitionCount;@JsonKey(name: 'compliance_score') int get complianceScore;@JsonKey(name: 'meeting_percent') double get meetingPercent;@JsonKey(name: 'task_percent') double get taskPercent;@JsonKey(name: 'risk_level') String get riskLevel;
/// Create a copy of MemberProfileOverviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileOverviewDtoCopyWith<MemberProfileOverviewDto> get copyWith => _$MemberProfileOverviewDtoCopyWithImpl<MemberProfileOverviewDto>(this as MemberProfileOverviewDto, _$identity);

  /// Serializes this MemberProfileOverviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileOverviewDto&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberProfileOverviewDto(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $MemberProfileOverviewDtoCopyWith<$Res>  {
  factory $MemberProfileOverviewDtoCopyWith(MemberProfileOverviewDto value, $Res Function(MemberProfileOverviewDto) _then) = _$MemberProfileOverviewDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leadership_score') int leadershipScore,@JsonKey(name: 'recognition_count') int recognitionCount,@JsonKey(name: 'compliance_score') int complianceScore,@JsonKey(name: 'meeting_percent') double meetingPercent,@JsonKey(name: 'task_percent') double taskPercent,@JsonKey(name: 'risk_level') String riskLevel
});




}
/// @nodoc
class _$MemberProfileOverviewDtoCopyWithImpl<$Res>
    implements $MemberProfileOverviewDtoCopyWith<$Res> {
  _$MemberProfileOverviewDtoCopyWithImpl(this._self, this._then);

  final MemberProfileOverviewDto _self;
  final $Res Function(MemberProfileOverviewDto) _then;

/// Create a copy of MemberProfileOverviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leadershipScore = null,Object? recognitionCount = null,Object? complianceScore = null,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,}) {
  return _then(_self.copyWith(
leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,complianceScore: null == complianceScore ? _self.complianceScore : complianceScore // ignore: cast_nullable_to_non_nullable
as int,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as double,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileOverviewDto].
extension MemberProfileOverviewDtoPatterns on MemberProfileOverviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileOverviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileOverviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileOverviewDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileOverviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileOverviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileOverviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileOverviewDto() when $default != null:
return $default(_that.leadershipScore,_that.recognitionCount,_that.complianceScore,_that.meetingPercent,_that.taskPercent,_that.riskLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileOverviewDto():
return $default(_that.leadershipScore,_that.recognitionCount,_that.complianceScore,_that.meetingPercent,_that.taskPercent,_that.riskLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  double meetingPercent, @JsonKey(name: 'task_percent')  double taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileOverviewDto() when $default != null:
return $default(_that.leadershipScore,_that.recognitionCount,_that.complianceScore,_that.meetingPercent,_that.taskPercent,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileOverviewDto implements MemberProfileOverviewDto {
  const _MemberProfileOverviewDto({@JsonKey(name: 'leadership_score') required this.leadershipScore, @JsonKey(name: 'recognition_count') required this.recognitionCount, @JsonKey(name: 'compliance_score') required this.complianceScore, @JsonKey(name: 'meeting_percent') required this.meetingPercent, @JsonKey(name: 'task_percent') required this.taskPercent, @JsonKey(name: 'risk_level') required this.riskLevel});
  factory _MemberProfileOverviewDto.fromJson(Map<String, dynamic> json) => _$MemberProfileOverviewDtoFromJson(json);

@override@JsonKey(name: 'leadership_score') final  int leadershipScore;
@override@JsonKey(name: 'recognition_count') final  int recognitionCount;
@override@JsonKey(name: 'compliance_score') final  int complianceScore;
@override@JsonKey(name: 'meeting_percent') final  double meetingPercent;
@override@JsonKey(name: 'task_percent') final  double taskPercent;
@override@JsonKey(name: 'risk_level') final  String riskLevel;

/// Create a copy of MemberProfileOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileOverviewDtoCopyWith<_MemberProfileOverviewDto> get copyWith => __$MemberProfileOverviewDtoCopyWithImpl<_MemberProfileOverviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileOverviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileOverviewDto&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberProfileOverviewDto(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileOverviewDtoCopyWith<$Res> implements $MemberProfileOverviewDtoCopyWith<$Res> {
  factory _$MemberProfileOverviewDtoCopyWith(_MemberProfileOverviewDto value, $Res Function(_MemberProfileOverviewDto) _then) = __$MemberProfileOverviewDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leadership_score') int leadershipScore,@JsonKey(name: 'recognition_count') int recognitionCount,@JsonKey(name: 'compliance_score') int complianceScore,@JsonKey(name: 'meeting_percent') double meetingPercent,@JsonKey(name: 'task_percent') double taskPercent,@JsonKey(name: 'risk_level') String riskLevel
});




}
/// @nodoc
class __$MemberProfileOverviewDtoCopyWithImpl<$Res>
    implements _$MemberProfileOverviewDtoCopyWith<$Res> {
  __$MemberProfileOverviewDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileOverviewDto _self;
  final $Res Function(_MemberProfileOverviewDto) _then;

/// Create a copy of MemberProfileOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipScore = null,Object? recognitionCount = null,Object? complianceScore = null,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,}) {
  return _then(_MemberProfileOverviewDto(
leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,complianceScore: null == complianceScore ? _self.complianceScore : complianceScore // ignore: cast_nullable_to_non_nullable
as int,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as double,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MemberProfileComplianceDto {

 int get score; List<String> get reasons;@JsonKey(name: 'next_improvement') String get nextImprovement;
/// Create a copy of MemberProfileComplianceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileComplianceDtoCopyWith<MemberProfileComplianceDto> get copyWith => _$MemberProfileComplianceDtoCopyWithImpl<MemberProfileComplianceDto>(this as MemberProfileComplianceDto, _$identity);

  /// Serializes this MemberProfileComplianceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileComplianceDto&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(reasons),nextImprovement);

@override
String toString() {
  return 'MemberProfileComplianceDto(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class $MemberProfileComplianceDtoCopyWith<$Res>  {
  factory $MemberProfileComplianceDtoCopyWith(MemberProfileComplianceDto value, $Res Function(MemberProfileComplianceDto) _then) = _$MemberProfileComplianceDtoCopyWithImpl;
@useResult
$Res call({
 int score, List<String> reasons,@JsonKey(name: 'next_improvement') String nextImprovement
});




}
/// @nodoc
class _$MemberProfileComplianceDtoCopyWithImpl<$Res>
    implements $MemberProfileComplianceDtoCopyWith<$Res> {
  _$MemberProfileComplianceDtoCopyWithImpl(this._self, this._then);

  final MemberProfileComplianceDto _self;
  final $Res Function(MemberProfileComplianceDto) _then;

/// Create a copy of MemberProfileComplianceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? reasons = null,Object? nextImprovement = null,}) {
  return _then(_self.copyWith(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,nextImprovement: null == nextImprovement ? _self.nextImprovement : nextImprovement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileComplianceDto].
extension MemberProfileComplianceDtoPatterns on MemberProfileComplianceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileComplianceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileComplianceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileComplianceDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileComplianceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileComplianceDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileComplianceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  List<String> reasons, @JsonKey(name: 'next_improvement')  String nextImprovement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileComplianceDto() when $default != null:
return $default(_that.score,_that.reasons,_that.nextImprovement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  List<String> reasons, @JsonKey(name: 'next_improvement')  String nextImprovement)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileComplianceDto():
return $default(_that.score,_that.reasons,_that.nextImprovement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  List<String> reasons, @JsonKey(name: 'next_improvement')  String nextImprovement)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileComplianceDto() when $default != null:
return $default(_that.score,_that.reasons,_that.nextImprovement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileComplianceDto implements MemberProfileComplianceDto {
  const _MemberProfileComplianceDto({required this.score, required final  List<String> reasons, @JsonKey(name: 'next_improvement') required this.nextImprovement}): _reasons = reasons;
  factory _MemberProfileComplianceDto.fromJson(Map<String, dynamic> json) => _$MemberProfileComplianceDtoFromJson(json);

@override final  int score;
 final  List<String> _reasons;
@override List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override@JsonKey(name: 'next_improvement') final  String nextImprovement;

/// Create a copy of MemberProfileComplianceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileComplianceDtoCopyWith<_MemberProfileComplianceDto> get copyWith => __$MemberProfileComplianceDtoCopyWithImpl<_MemberProfileComplianceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileComplianceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileComplianceDto&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_reasons),nextImprovement);

@override
String toString() {
  return 'MemberProfileComplianceDto(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileComplianceDtoCopyWith<$Res> implements $MemberProfileComplianceDtoCopyWith<$Res> {
  factory _$MemberProfileComplianceDtoCopyWith(_MemberProfileComplianceDto value, $Res Function(_MemberProfileComplianceDto) _then) = __$MemberProfileComplianceDtoCopyWithImpl;
@override @useResult
$Res call({
 int score, List<String> reasons,@JsonKey(name: 'next_improvement') String nextImprovement
});




}
/// @nodoc
class __$MemberProfileComplianceDtoCopyWithImpl<$Res>
    implements _$MemberProfileComplianceDtoCopyWith<$Res> {
  __$MemberProfileComplianceDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileComplianceDto _self;
  final $Res Function(_MemberProfileComplianceDto) _then;

/// Create a copy of MemberProfileComplianceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? reasons = null,Object? nextImprovement = null,}) {
  return _then(_MemberProfileComplianceDto(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,nextImprovement: null == nextImprovement ? _self.nextImprovement : nextImprovement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MemberProfileTimelineDto {

 String get type; DateTime get timestamp; String get title; String get description;
/// Create a copy of MemberProfileTimelineDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileTimelineDtoCopyWith<MemberProfileTimelineDto> get copyWith => _$MemberProfileTimelineDtoCopyWithImpl<MemberProfileTimelineDto>(this as MemberProfileTimelineDto, _$identity);

  /// Serializes this MemberProfileTimelineDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileTimelineDto&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,title,description);

@override
String toString() {
  return 'MemberProfileTimelineDto(type: $type, timestamp: $timestamp, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $MemberProfileTimelineDtoCopyWith<$Res>  {
  factory $MemberProfileTimelineDtoCopyWith(MemberProfileTimelineDto value, $Res Function(MemberProfileTimelineDto) _then) = _$MemberProfileTimelineDtoCopyWithImpl;
@useResult
$Res call({
 String type, DateTime timestamp, String title, String description
});




}
/// @nodoc
class _$MemberProfileTimelineDtoCopyWithImpl<$Res>
    implements $MemberProfileTimelineDtoCopyWith<$Res> {
  _$MemberProfileTimelineDtoCopyWithImpl(this._self, this._then);

  final MemberProfileTimelineDto _self;
  final $Res Function(MemberProfileTimelineDto) _then;

/// Create a copy of MemberProfileTimelineDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileTimelineDto].
extension MemberProfileTimelineDtoPatterns on MemberProfileTimelineDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileTimelineDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileTimelineDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileTimelineDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileTimelineDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileTimelineDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileTimelineDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  DateTime timestamp,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileTimelineDto() when $default != null:
return $default(_that.type,_that.timestamp,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  DateTime timestamp,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileTimelineDto():
return $default(_that.type,_that.timestamp,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  DateTime timestamp,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileTimelineDto() when $default != null:
return $default(_that.type,_that.timestamp,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileTimelineDto implements MemberProfileTimelineDto {
  const _MemberProfileTimelineDto({required this.type, required this.timestamp, required this.title, required this.description});
  factory _MemberProfileTimelineDto.fromJson(Map<String, dynamic> json) => _$MemberProfileTimelineDtoFromJson(json);

@override final  String type;
@override final  DateTime timestamp;
@override final  String title;
@override final  String description;

/// Create a copy of MemberProfileTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileTimelineDtoCopyWith<_MemberProfileTimelineDto> get copyWith => __$MemberProfileTimelineDtoCopyWithImpl<_MemberProfileTimelineDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileTimelineDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileTimelineDto&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,title,description);

@override
String toString() {
  return 'MemberProfileTimelineDto(type: $type, timestamp: $timestamp, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileTimelineDtoCopyWith<$Res> implements $MemberProfileTimelineDtoCopyWith<$Res> {
  factory _$MemberProfileTimelineDtoCopyWith(_MemberProfileTimelineDto value, $Res Function(_MemberProfileTimelineDto) _then) = __$MemberProfileTimelineDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, DateTime timestamp, String title, String description
});




}
/// @nodoc
class __$MemberProfileTimelineDtoCopyWithImpl<$Res>
    implements _$MemberProfileTimelineDtoCopyWith<$Res> {
  __$MemberProfileTimelineDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileTimelineDto _self;
  final $Res Function(_MemberProfileTimelineDto) _then;

/// Create a copy of MemberProfileTimelineDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? title = null,Object? description = null,}) {
  return _then(_MemberProfileTimelineDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MemberProfileRecognitionDto {

 String get name; String get description;@JsonKey(name: 'earned_date') DateTime get earnedDate; String get category; String get icon; int get level; int get points;
/// Create a copy of MemberProfileRecognitionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileRecognitionDtoCopyWith<MemberProfileRecognitionDto> get copyWith => _$MemberProfileRecognitionDtoCopyWithImpl<MemberProfileRecognitionDto>(this as MemberProfileRecognitionDto, _$identity);

  /// Serializes this MemberProfileRecognitionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileRecognitionDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberProfileRecognitionDto(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class $MemberProfileRecognitionDtoCopyWith<$Res>  {
  factory $MemberProfileRecognitionDtoCopyWith(MemberProfileRecognitionDto value, $Res Function(MemberProfileRecognitionDto) _then) = _$MemberProfileRecognitionDtoCopyWithImpl;
@useResult
$Res call({
 String name, String description,@JsonKey(name: 'earned_date') DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class _$MemberProfileRecognitionDtoCopyWithImpl<$Res>
    implements $MemberProfileRecognitionDtoCopyWith<$Res> {
  _$MemberProfileRecognitionDtoCopyWithImpl(this._self, this._then);

  final MemberProfileRecognitionDto _self;
  final $Res Function(MemberProfileRecognitionDto) _then;

/// Create a copy of MemberProfileRecognitionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? earnedDate = null,Object? category = null,Object? icon = null,Object? level = null,Object? points = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,earnedDate: null == earnedDate ? _self.earnedDate : earnedDate // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileRecognitionDto].
extension MemberProfileRecognitionDtoPatterns on MemberProfileRecognitionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileRecognitionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileRecognitionDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileRecognitionDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description, @JsonKey(name: 'earned_date')  DateTime earnedDate,  String category,  String icon,  int level,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto() when $default != null:
return $default(_that.name,_that.description,_that.earnedDate,_that.category,_that.icon,_that.level,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description, @JsonKey(name: 'earned_date')  DateTime earnedDate,  String category,  String icon,  int level,  int points)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto():
return $default(_that.name,_that.description,_that.earnedDate,_that.category,_that.icon,_that.level,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description, @JsonKey(name: 'earned_date')  DateTime earnedDate,  String category,  String icon,  int level,  int points)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileRecognitionDto() when $default != null:
return $default(_that.name,_that.description,_that.earnedDate,_that.category,_that.icon,_that.level,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileRecognitionDto implements MemberProfileRecognitionDto {
  const _MemberProfileRecognitionDto({required this.name, required this.description, @JsonKey(name: 'earned_date') required this.earnedDate, required this.category, required this.icon, required this.level, required this.points});
  factory _MemberProfileRecognitionDto.fromJson(Map<String, dynamic> json) => _$MemberProfileRecognitionDtoFromJson(json);

@override final  String name;
@override final  String description;
@override@JsonKey(name: 'earned_date') final  DateTime earnedDate;
@override final  String category;
@override final  String icon;
@override final  int level;
@override final  int points;

/// Create a copy of MemberProfileRecognitionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileRecognitionDtoCopyWith<_MemberProfileRecognitionDto> get copyWith => __$MemberProfileRecognitionDtoCopyWithImpl<_MemberProfileRecognitionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileRecognitionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileRecognitionDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberProfileRecognitionDto(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileRecognitionDtoCopyWith<$Res> implements $MemberProfileRecognitionDtoCopyWith<$Res> {
  factory _$MemberProfileRecognitionDtoCopyWith(_MemberProfileRecognitionDto value, $Res Function(_MemberProfileRecognitionDto) _then) = __$MemberProfileRecognitionDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String description,@JsonKey(name: 'earned_date') DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class __$MemberProfileRecognitionDtoCopyWithImpl<$Res>
    implements _$MemberProfileRecognitionDtoCopyWith<$Res> {
  __$MemberProfileRecognitionDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileRecognitionDto _self;
  final $Res Function(_MemberProfileRecognitionDto) _then;

/// Create a copy of MemberProfileRecognitionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? earnedDate = null,Object? category = null,Object? icon = null,Object? level = null,Object? points = null,}) {
  return _then(_MemberProfileRecognitionDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,earnedDate: null == earnedDate ? _self.earnedDate : earnedDate // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MemberProfileAnalyticsDto {

@JsonKey(name: 'leadership_trend') List<int> get leadershipTrend;@JsonKey(name: 'attendance_trend') List<int> get attendanceTrend;@JsonKey(name: 'task_trend') List<int> get taskTrend;
/// Create a copy of MemberProfileAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileAnalyticsDtoCopyWith<MemberProfileAnalyticsDto> get copyWith => _$MemberProfileAnalyticsDtoCopyWithImpl<MemberProfileAnalyticsDto>(this as MemberProfileAnalyticsDto, _$identity);

  /// Serializes this MemberProfileAnalyticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileAnalyticsDto&&const DeepCollectionEquality().equals(other.leadershipTrend, leadershipTrend)&&const DeepCollectionEquality().equals(other.attendanceTrend, attendanceTrend)&&const DeepCollectionEquality().equals(other.taskTrend, taskTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leadershipTrend),const DeepCollectionEquality().hash(attendanceTrend),const DeepCollectionEquality().hash(taskTrend));

@override
String toString() {
  return 'MemberProfileAnalyticsDto(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class $MemberProfileAnalyticsDtoCopyWith<$Res>  {
  factory $MemberProfileAnalyticsDtoCopyWith(MemberProfileAnalyticsDto value, $Res Function(MemberProfileAnalyticsDto) _then) = _$MemberProfileAnalyticsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leadership_trend') List<int> leadershipTrend,@JsonKey(name: 'attendance_trend') List<int> attendanceTrend,@JsonKey(name: 'task_trend') List<int> taskTrend
});




}
/// @nodoc
class _$MemberProfileAnalyticsDtoCopyWithImpl<$Res>
    implements $MemberProfileAnalyticsDtoCopyWith<$Res> {
  _$MemberProfileAnalyticsDtoCopyWithImpl(this._self, this._then);

  final MemberProfileAnalyticsDto _self;
  final $Res Function(MemberProfileAnalyticsDto) _then;

/// Create a copy of MemberProfileAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leadershipTrend = null,Object? attendanceTrend = null,Object? taskTrend = null,}) {
  return _then(_self.copyWith(
leadershipTrend: null == leadershipTrend ? _self.leadershipTrend : leadershipTrend // ignore: cast_nullable_to_non_nullable
as List<int>,attendanceTrend: null == attendanceTrend ? _self.attendanceTrend : attendanceTrend // ignore: cast_nullable_to_non_nullable
as List<int>,taskTrend: null == taskTrend ? _self.taskTrend : taskTrend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileAnalyticsDto].
extension MemberProfileAnalyticsDtoPatterns on MemberProfileAnalyticsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileAnalyticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileAnalyticsDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileAnalyticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_trend')  List<int> leadershipTrend, @JsonKey(name: 'attendance_trend')  List<int> attendanceTrend, @JsonKey(name: 'task_trend')  List<int> taskTrend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto() when $default != null:
return $default(_that.leadershipTrend,_that.attendanceTrend,_that.taskTrend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_trend')  List<int> leadershipTrend, @JsonKey(name: 'attendance_trend')  List<int> attendanceTrend, @JsonKey(name: 'task_trend')  List<int> taskTrend)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto():
return $default(_that.leadershipTrend,_that.attendanceTrend,_that.taskTrend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leadership_trend')  List<int> leadershipTrend, @JsonKey(name: 'attendance_trend')  List<int> attendanceTrend, @JsonKey(name: 'task_trend')  List<int> taskTrend)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileAnalyticsDto() when $default != null:
return $default(_that.leadershipTrend,_that.attendanceTrend,_that.taskTrend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileAnalyticsDto implements MemberProfileAnalyticsDto {
  const _MemberProfileAnalyticsDto({@JsonKey(name: 'leadership_trend') required final  List<int> leadershipTrend, @JsonKey(name: 'attendance_trend') required final  List<int> attendanceTrend, @JsonKey(name: 'task_trend') required final  List<int> taskTrend}): _leadershipTrend = leadershipTrend,_attendanceTrend = attendanceTrend,_taskTrend = taskTrend;
  factory _MemberProfileAnalyticsDto.fromJson(Map<String, dynamic> json) => _$MemberProfileAnalyticsDtoFromJson(json);

 final  List<int> _leadershipTrend;
@override@JsonKey(name: 'leadership_trend') List<int> get leadershipTrend {
  if (_leadershipTrend is EqualUnmodifiableListView) return _leadershipTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leadershipTrend);
}

 final  List<int> _attendanceTrend;
@override@JsonKey(name: 'attendance_trend') List<int> get attendanceTrend {
  if (_attendanceTrend is EqualUnmodifiableListView) return _attendanceTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendanceTrend);
}

 final  List<int> _taskTrend;
@override@JsonKey(name: 'task_trend') List<int> get taskTrend {
  if (_taskTrend is EqualUnmodifiableListView) return _taskTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taskTrend);
}


/// Create a copy of MemberProfileAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileAnalyticsDtoCopyWith<_MemberProfileAnalyticsDto> get copyWith => __$MemberProfileAnalyticsDtoCopyWithImpl<_MemberProfileAnalyticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileAnalyticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileAnalyticsDto&&const DeepCollectionEquality().equals(other._leadershipTrend, _leadershipTrend)&&const DeepCollectionEquality().equals(other._attendanceTrend, _attendanceTrend)&&const DeepCollectionEquality().equals(other._taskTrend, _taskTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leadershipTrend),const DeepCollectionEquality().hash(_attendanceTrend),const DeepCollectionEquality().hash(_taskTrend));

@override
String toString() {
  return 'MemberProfileAnalyticsDto(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileAnalyticsDtoCopyWith<$Res> implements $MemberProfileAnalyticsDtoCopyWith<$Res> {
  factory _$MemberProfileAnalyticsDtoCopyWith(_MemberProfileAnalyticsDto value, $Res Function(_MemberProfileAnalyticsDto) _then) = __$MemberProfileAnalyticsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leadership_trend') List<int> leadershipTrend,@JsonKey(name: 'attendance_trend') List<int> attendanceTrend,@JsonKey(name: 'task_trend') List<int> taskTrend
});




}
/// @nodoc
class __$MemberProfileAnalyticsDtoCopyWithImpl<$Res>
    implements _$MemberProfileAnalyticsDtoCopyWith<$Res> {
  __$MemberProfileAnalyticsDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileAnalyticsDto _self;
  final $Res Function(_MemberProfileAnalyticsDto) _then;

/// Create a copy of MemberProfileAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipTrend = null,Object? attendanceTrend = null,Object? taskTrend = null,}) {
  return _then(_MemberProfileAnalyticsDto(
leadershipTrend: null == leadershipTrend ? _self._leadershipTrend : leadershipTrend // ignore: cast_nullable_to_non_nullable
as List<int>,attendanceTrend: null == attendanceTrend ? _self._attendanceTrend : attendanceTrend // ignore: cast_nullable_to_non_nullable
as List<int>,taskTrend: null == taskTrend ? _self._taskTrend : taskTrend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
