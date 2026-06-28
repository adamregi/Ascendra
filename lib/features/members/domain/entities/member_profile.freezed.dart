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

 MemberProfileHero get hero; MemberProfileOverview get overview; MemberProfileCompliance get compliance; List<MemberTimelineEvent> get timeline; List<MemberRecognition> get recognition; MemberAnalytics get analytics;
/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileCopyWith<MemberProfile> get copyWith => _$MemberProfileCopyWithImpl<MemberProfile>(this as MemberProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfile&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.recognition, recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}


@override
int get hashCode => Object.hash(runtimeType,hero,overview,compliance,const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(recognition),analytics);

@override
String toString() {
  return 'MemberProfile(hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class $MemberProfileCopyWith<$Res>  {
  factory $MemberProfileCopyWith(MemberProfile value, $Res Function(MemberProfile) _then) = _$MemberProfileCopyWithImpl;
@useResult
$Res call({
 MemberProfileHero hero, MemberProfileOverview overview, MemberProfileCompliance compliance, List<MemberTimelineEvent> timeline, List<MemberRecognition> recognition, MemberAnalytics analytics
});


$MemberProfileHeroCopyWith<$Res> get hero;$MemberProfileOverviewCopyWith<$Res> get overview;$MemberProfileComplianceCopyWith<$Res> get compliance;$MemberAnalyticsCopyWith<$Res> get analytics;

}
/// @nodoc
class _$MemberProfileCopyWithImpl<$Res>
    implements $MemberProfileCopyWith<$Res> {
  _$MemberProfileCopyWithImpl(this._self, this._then);

  final MemberProfile _self;
  final $Res Function(MemberProfile) _then;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_self.copyWith(
hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberProfileHero,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberProfileOverview,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberProfileCompliance,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberTimelineEvent>,recognition: null == recognition ? _self.recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberRecognition>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberAnalytics,
  ));
}
/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileHeroCopyWith<$Res> get hero {
  
  return $MemberProfileHeroCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileOverviewCopyWith<$Res> get overview {
  
  return $MemberProfileOverviewCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileComplianceCopyWith<$Res> get compliance {
  
  return $MemberProfileComplianceCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberAnalyticsCopyWith<$Res> get analytics {
  
  return $MemberAnalyticsCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberProfileHero hero,  MemberProfileOverview overview,  MemberProfileCompliance compliance,  List<MemberTimelineEvent> timeline,  List<MemberRecognition> recognition,  MemberAnalytics analytics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
return $default(_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberProfileHero hero,  MemberProfileOverview overview,  MemberProfileCompliance compliance,  List<MemberTimelineEvent> timeline,  List<MemberRecognition> recognition,  MemberAnalytics analytics)  $default,) {final _that = this;
switch (_that) {
case _MemberProfile():
return $default(_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberProfileHero hero,  MemberProfileOverview overview,  MemberProfileCompliance compliance,  List<MemberTimelineEvent> timeline,  List<MemberRecognition> recognition,  MemberAnalytics analytics)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfile() when $default != null:
return $default(_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
  return null;

}
}

}

/// @nodoc


class _MemberProfile implements MemberProfile {
  const _MemberProfile({required this.hero, required this.overview, required this.compliance, required final  List<MemberTimelineEvent> timeline, required final  List<MemberRecognition> recognition, required this.analytics}): _timeline = timeline,_recognition = recognition;
  

@override final  MemberProfileHero hero;
@override final  MemberProfileOverview overview;
@override final  MemberProfileCompliance compliance;
 final  List<MemberTimelineEvent> _timeline;
@override List<MemberTimelineEvent> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<MemberRecognition> _recognition;
@override List<MemberRecognition> get recognition {
  if (_recognition is EqualUnmodifiableListView) return _recognition;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognition);
}

@override final  MemberAnalytics analytics;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileCopyWith<_MemberProfile> get copyWith => __$MemberProfileCopyWithImpl<_MemberProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfile&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._recognition, _recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}


@override
int get hashCode => Object.hash(runtimeType,hero,overview,compliance,const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_recognition),analytics);

@override
String toString() {
  return 'MemberProfile(hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileCopyWith<$Res> implements $MemberProfileCopyWith<$Res> {
  factory _$MemberProfileCopyWith(_MemberProfile value, $Res Function(_MemberProfile) _then) = __$MemberProfileCopyWithImpl;
@override @useResult
$Res call({
 MemberProfileHero hero, MemberProfileOverview overview, MemberProfileCompliance compliance, List<MemberTimelineEvent> timeline, List<MemberRecognition> recognition, MemberAnalytics analytics
});


@override $MemberProfileHeroCopyWith<$Res> get hero;@override $MemberProfileOverviewCopyWith<$Res> get overview;@override $MemberProfileComplianceCopyWith<$Res> get compliance;@override $MemberAnalyticsCopyWith<$Res> get analytics;

}
/// @nodoc
class __$MemberProfileCopyWithImpl<$Res>
    implements _$MemberProfileCopyWith<$Res> {
  __$MemberProfileCopyWithImpl(this._self, this._then);

  final _MemberProfile _self;
  final $Res Function(_MemberProfile) _then;

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_MemberProfile(
hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberProfileHero,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberProfileOverview,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberProfileCompliance,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberTimelineEvent>,recognition: null == recognition ? _self._recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberRecognition>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberAnalytics,
  ));
}

/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileHeroCopyWith<$Res> get hero {
  
  return $MemberProfileHeroCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileOverviewCopyWith<$Res> get overview {
  
  return $MemberProfileOverviewCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileComplianceCopyWith<$Res> get compliance {
  
  return $MemberProfileComplianceCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberAnalyticsCopyWith<$Res> get analytics {
  
  return $MemberAnalyticsCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
}
}

/// @nodoc
mixin _$MemberProfileHero {

 String? get avatarUrl; String get firstName; String get lastName; String get distributorId; String? get leaderName; String get rank; String get status; DateTime get joinedDate; int get currentStreak;
/// Create a copy of MemberProfileHero
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileHeroCopyWith<MemberProfileHero> get copyWith => _$MemberProfileHeroCopyWithImpl<MemberProfileHero>(this as MemberProfileHero, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileHero&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}


@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberProfileHero(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class $MemberProfileHeroCopyWith<$Res>  {
  factory $MemberProfileHeroCopyWith(MemberProfileHero value, $Res Function(MemberProfileHero) _then) = _$MemberProfileHeroCopyWithImpl;
@useResult
$Res call({
 String? avatarUrl, String firstName, String lastName, String distributorId, String? leaderName, String rank, String status, DateTime joinedDate, int currentStreak
});




}
/// @nodoc
class _$MemberProfileHeroCopyWithImpl<$Res>
    implements $MemberProfileHeroCopyWith<$Res> {
  _$MemberProfileHeroCopyWithImpl(this._self, this._then);

  final MemberProfileHero _self;
  final $Res Function(MemberProfileHero) _then;

/// Create a copy of MemberProfileHero
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


/// Adds pattern-matching-related methods to [MemberProfileHero].
extension MemberProfileHeroPatterns on MemberProfileHero {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileHero value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileHero() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileHero value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileHero():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileHero value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileHero() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? avatarUrl,  String firstName,  String lastName,  String distributorId,  String? leaderName,  String rank,  String status,  DateTime joinedDate,  int currentStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileHero() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? avatarUrl,  String firstName,  String lastName,  String distributorId,  String? leaderName,  String rank,  String status,  DateTime joinedDate,  int currentStreak)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileHero():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? avatarUrl,  String firstName,  String lastName,  String distributorId,  String? leaderName,  String rank,  String status,  DateTime joinedDate,  int currentStreak)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileHero() when $default != null:
return $default(_that.avatarUrl,_that.firstName,_that.lastName,_that.distributorId,_that.leaderName,_that.rank,_that.status,_that.joinedDate,_that.currentStreak);case _:
  return null;

}
}

}

/// @nodoc


class _MemberProfileHero implements MemberProfileHero {
  const _MemberProfileHero({this.avatarUrl, required this.firstName, required this.lastName, required this.distributorId, this.leaderName, required this.rank, required this.status, required this.joinedDate, required this.currentStreak});
  

@override final  String? avatarUrl;
@override final  String firstName;
@override final  String lastName;
@override final  String distributorId;
@override final  String? leaderName;
@override final  String rank;
@override final  String status;
@override final  DateTime joinedDate;
@override final  int currentStreak;

/// Create a copy of MemberProfileHero
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileHeroCopyWith<_MemberProfileHero> get copyWith => __$MemberProfileHeroCopyWithImpl<_MemberProfileHero>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileHero&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}


@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberProfileHero(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileHeroCopyWith<$Res> implements $MemberProfileHeroCopyWith<$Res> {
  factory _$MemberProfileHeroCopyWith(_MemberProfileHero value, $Res Function(_MemberProfileHero) _then) = __$MemberProfileHeroCopyWithImpl;
@override @useResult
$Res call({
 String? avatarUrl, String firstName, String lastName, String distributorId, String? leaderName, String rank, String status, DateTime joinedDate, int currentStreak
});




}
/// @nodoc
class __$MemberProfileHeroCopyWithImpl<$Res>
    implements _$MemberProfileHeroCopyWith<$Res> {
  __$MemberProfileHeroCopyWithImpl(this._self, this._then);

  final _MemberProfileHero _self;
  final $Res Function(_MemberProfileHero) _then;

/// Create a copy of MemberProfileHero
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatarUrl = freezed,Object? firstName = null,Object? lastName = null,Object? distributorId = null,Object? leaderName = freezed,Object? rank = null,Object? status = null,Object? joinedDate = null,Object? currentStreak = null,}) {
  return _then(_MemberProfileHero(
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
mixin _$MemberProfileOverview {

 int get leadershipScore; int get recognitionCount; int get complianceScore; double get meetingPercent; double get taskPercent; String get riskLevel;
/// Create a copy of MemberProfileOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileOverviewCopyWith<MemberProfileOverview> get copyWith => _$MemberProfileOverviewCopyWithImpl<MemberProfileOverview>(this as MemberProfileOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileOverview&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}


@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberProfileOverview(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $MemberProfileOverviewCopyWith<$Res>  {
  factory $MemberProfileOverviewCopyWith(MemberProfileOverview value, $Res Function(MemberProfileOverview) _then) = _$MemberProfileOverviewCopyWithImpl;
@useResult
$Res call({
 int leadershipScore, int recognitionCount, int complianceScore, double meetingPercent, double taskPercent, String riskLevel
});




}
/// @nodoc
class _$MemberProfileOverviewCopyWithImpl<$Res>
    implements $MemberProfileOverviewCopyWith<$Res> {
  _$MemberProfileOverviewCopyWithImpl(this._self, this._then);

  final MemberProfileOverview _self;
  final $Res Function(MemberProfileOverview) _then;

/// Create a copy of MemberProfileOverview
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


/// Adds pattern-matching-related methods to [MemberProfileOverview].
extension MemberProfileOverviewPatterns on MemberProfileOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileOverview value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileOverview value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int leadershipScore,  int recognitionCount,  int complianceScore,  double meetingPercent,  double taskPercent,  String riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileOverview() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int leadershipScore,  int recognitionCount,  int complianceScore,  double meetingPercent,  double taskPercent,  String riskLevel)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileOverview():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int leadershipScore,  int recognitionCount,  int complianceScore,  double meetingPercent,  double taskPercent,  String riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileOverview() when $default != null:
return $default(_that.leadershipScore,_that.recognitionCount,_that.complianceScore,_that.meetingPercent,_that.taskPercent,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc


class _MemberProfileOverview implements MemberProfileOverview {
  const _MemberProfileOverview({required this.leadershipScore, required this.recognitionCount, required this.complianceScore, required this.meetingPercent, required this.taskPercent, required this.riskLevel});
  

@override final  int leadershipScore;
@override final  int recognitionCount;
@override final  int complianceScore;
@override final  double meetingPercent;
@override final  double taskPercent;
@override final  String riskLevel;

/// Create a copy of MemberProfileOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileOverviewCopyWith<_MemberProfileOverview> get copyWith => __$MemberProfileOverviewCopyWithImpl<_MemberProfileOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileOverview&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}


@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberProfileOverview(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileOverviewCopyWith<$Res> implements $MemberProfileOverviewCopyWith<$Res> {
  factory _$MemberProfileOverviewCopyWith(_MemberProfileOverview value, $Res Function(_MemberProfileOverview) _then) = __$MemberProfileOverviewCopyWithImpl;
@override @useResult
$Res call({
 int leadershipScore, int recognitionCount, int complianceScore, double meetingPercent, double taskPercent, String riskLevel
});




}
/// @nodoc
class __$MemberProfileOverviewCopyWithImpl<$Res>
    implements _$MemberProfileOverviewCopyWith<$Res> {
  __$MemberProfileOverviewCopyWithImpl(this._self, this._then);

  final _MemberProfileOverview _self;
  final $Res Function(_MemberProfileOverview) _then;

/// Create a copy of MemberProfileOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipScore = null,Object? recognitionCount = null,Object? complianceScore = null,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,}) {
  return _then(_MemberProfileOverview(
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
mixin _$MemberProfileCompliance {

 int get score; List<String> get reasons; String get nextImprovement;
/// Create a copy of MemberProfileCompliance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileComplianceCopyWith<MemberProfileCompliance> get copyWith => _$MemberProfileComplianceCopyWithImpl<MemberProfileCompliance>(this as MemberProfileCompliance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileCompliance&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}


@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(reasons),nextImprovement);

@override
String toString() {
  return 'MemberProfileCompliance(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class $MemberProfileComplianceCopyWith<$Res>  {
  factory $MemberProfileComplianceCopyWith(MemberProfileCompliance value, $Res Function(MemberProfileCompliance) _then) = _$MemberProfileComplianceCopyWithImpl;
@useResult
$Res call({
 int score, List<String> reasons, String nextImprovement
});




}
/// @nodoc
class _$MemberProfileComplianceCopyWithImpl<$Res>
    implements $MemberProfileComplianceCopyWith<$Res> {
  _$MemberProfileComplianceCopyWithImpl(this._self, this._then);

  final MemberProfileCompliance _self;
  final $Res Function(MemberProfileCompliance) _then;

/// Create a copy of MemberProfileCompliance
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


/// Adds pattern-matching-related methods to [MemberProfileCompliance].
extension MemberProfileCompliancePatterns on MemberProfileCompliance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileCompliance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileCompliance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileCompliance value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileCompliance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileCompliance value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileCompliance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  List<String> reasons,  String nextImprovement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileCompliance() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  List<String> reasons,  String nextImprovement)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileCompliance():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  List<String> reasons,  String nextImprovement)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileCompliance() when $default != null:
return $default(_that.score,_that.reasons,_that.nextImprovement);case _:
  return null;

}
}

}

/// @nodoc


class _MemberProfileCompliance implements MemberProfileCompliance {
  const _MemberProfileCompliance({required this.score, required final  List<String> reasons, required this.nextImprovement}): _reasons = reasons;
  

@override final  int score;
 final  List<String> _reasons;
@override List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override final  String nextImprovement;

/// Create a copy of MemberProfileCompliance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileComplianceCopyWith<_MemberProfileCompliance> get copyWith => __$MemberProfileComplianceCopyWithImpl<_MemberProfileCompliance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileCompliance&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}


@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_reasons),nextImprovement);

@override
String toString() {
  return 'MemberProfileCompliance(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileComplianceCopyWith<$Res> implements $MemberProfileComplianceCopyWith<$Res> {
  factory _$MemberProfileComplianceCopyWith(_MemberProfileCompliance value, $Res Function(_MemberProfileCompliance) _then) = __$MemberProfileComplianceCopyWithImpl;
@override @useResult
$Res call({
 int score, List<String> reasons, String nextImprovement
});




}
/// @nodoc
class __$MemberProfileComplianceCopyWithImpl<$Res>
    implements _$MemberProfileComplianceCopyWith<$Res> {
  __$MemberProfileComplianceCopyWithImpl(this._self, this._then);

  final _MemberProfileCompliance _self;
  final $Res Function(_MemberProfileCompliance) _then;

/// Create a copy of MemberProfileCompliance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? reasons = null,Object? nextImprovement = null,}) {
  return _then(_MemberProfileCompliance(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,nextImprovement: null == nextImprovement ? _self.nextImprovement : nextImprovement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MemberTimelineEvent {

 TimelineEventType get type; DateTime get timestamp; String get title; String get description;
/// Create a copy of MemberTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberTimelineEventCopyWith<MemberTimelineEvent> get copyWith => _$MemberTimelineEventCopyWithImpl<MemberTimelineEvent>(this as MemberTimelineEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberTimelineEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,title,description);

@override
String toString() {
  return 'MemberTimelineEvent(type: $type, timestamp: $timestamp, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $MemberTimelineEventCopyWith<$Res>  {
  factory $MemberTimelineEventCopyWith(MemberTimelineEvent value, $Res Function(MemberTimelineEvent) _then) = _$MemberTimelineEventCopyWithImpl;
@useResult
$Res call({
 TimelineEventType type, DateTime timestamp, String title, String description
});




}
/// @nodoc
class _$MemberTimelineEventCopyWithImpl<$Res>
    implements $MemberTimelineEventCopyWith<$Res> {
  _$MemberTimelineEventCopyWithImpl(this._self, this._then);

  final MemberTimelineEvent _self;
  final $Res Function(MemberTimelineEvent) _then;

/// Create a copy of MemberTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberTimelineEvent].
extension MemberTimelineEventPatterns on MemberTimelineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberTimelineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberTimelineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberTimelineEvent value)  $default,){
final _that = this;
switch (_that) {
case _MemberTimelineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberTimelineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _MemberTimelineEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimelineEventType type,  DateTime timestamp,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberTimelineEvent() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimelineEventType type,  DateTime timestamp,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _MemberTimelineEvent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimelineEventType type,  DateTime timestamp,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _MemberTimelineEvent() when $default != null:
return $default(_that.type,_that.timestamp,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _MemberTimelineEvent implements MemberTimelineEvent {
  const _MemberTimelineEvent({required this.type, required this.timestamp, required this.title, required this.description});
  

@override final  TimelineEventType type;
@override final  DateTime timestamp;
@override final  String title;
@override final  String description;

/// Create a copy of MemberTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberTimelineEventCopyWith<_MemberTimelineEvent> get copyWith => __$MemberTimelineEventCopyWithImpl<_MemberTimelineEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberTimelineEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,type,timestamp,title,description);

@override
String toString() {
  return 'MemberTimelineEvent(type: $type, timestamp: $timestamp, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$MemberTimelineEventCopyWith<$Res> implements $MemberTimelineEventCopyWith<$Res> {
  factory _$MemberTimelineEventCopyWith(_MemberTimelineEvent value, $Res Function(_MemberTimelineEvent) _then) = __$MemberTimelineEventCopyWithImpl;
@override @useResult
$Res call({
 TimelineEventType type, DateTime timestamp, String title, String description
});




}
/// @nodoc
class __$MemberTimelineEventCopyWithImpl<$Res>
    implements _$MemberTimelineEventCopyWith<$Res> {
  __$MemberTimelineEventCopyWithImpl(this._self, this._then);

  final _MemberTimelineEvent _self;
  final $Res Function(_MemberTimelineEvent) _then;

/// Create a copy of MemberTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? title = null,Object? description = null,}) {
  return _then(_MemberTimelineEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MemberRecognition {

 String get name; String get description; DateTime get earnedDate; String get category; String get icon; int get level; int get points;
/// Create a copy of MemberRecognition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberRecognitionCopyWith<MemberRecognition> get copyWith => _$MemberRecognitionCopyWithImpl<MemberRecognition>(this as MemberRecognition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRecognition&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberRecognition(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class $MemberRecognitionCopyWith<$Res>  {
  factory $MemberRecognitionCopyWith(MemberRecognition value, $Res Function(MemberRecognition) _then) = _$MemberRecognitionCopyWithImpl;
@useResult
$Res call({
 String name, String description, DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class _$MemberRecognitionCopyWithImpl<$Res>
    implements $MemberRecognitionCopyWith<$Res> {
  _$MemberRecognitionCopyWithImpl(this._self, this._then);

  final MemberRecognition _self;
  final $Res Function(MemberRecognition) _then;

/// Create a copy of MemberRecognition
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


/// Adds pattern-matching-related methods to [MemberRecognition].
extension MemberRecognitionPatterns on MemberRecognition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberRecognition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberRecognition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberRecognition value)  $default,){
final _that = this;
switch (_that) {
case _MemberRecognition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberRecognition value)?  $default,){
final _that = this;
switch (_that) {
case _MemberRecognition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  DateTime earnedDate,  String category,  String icon,  int level,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberRecognition() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  DateTime earnedDate,  String category,  String icon,  int level,  int points)  $default,) {final _that = this;
switch (_that) {
case _MemberRecognition():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  DateTime earnedDate,  String category,  String icon,  int level,  int points)?  $default,) {final _that = this;
switch (_that) {
case _MemberRecognition() when $default != null:
return $default(_that.name,_that.description,_that.earnedDate,_that.category,_that.icon,_that.level,_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _MemberRecognition implements MemberRecognition {
  const _MemberRecognition({required this.name, required this.description, required this.earnedDate, required this.category, required this.icon, required this.level, required this.points});
  

@override final  String name;
@override final  String description;
@override final  DateTime earnedDate;
@override final  String category;
@override final  String icon;
@override final  int level;
@override final  int points;

/// Create a copy of MemberRecognition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberRecognitionCopyWith<_MemberRecognition> get copyWith => __$MemberRecognitionCopyWithImpl<_MemberRecognition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberRecognition&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberRecognition(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class _$MemberRecognitionCopyWith<$Res> implements $MemberRecognitionCopyWith<$Res> {
  factory _$MemberRecognitionCopyWith(_MemberRecognition value, $Res Function(_MemberRecognition) _then) = __$MemberRecognitionCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class __$MemberRecognitionCopyWithImpl<$Res>
    implements _$MemberRecognitionCopyWith<$Res> {
  __$MemberRecognitionCopyWithImpl(this._self, this._then);

  final _MemberRecognition _self;
  final $Res Function(_MemberRecognition) _then;

/// Create a copy of MemberRecognition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? earnedDate = null,Object? category = null,Object? icon = null,Object? level = null,Object? points = null,}) {
  return _then(_MemberRecognition(
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
mixin _$MemberAnalytics {

 List<int> get leadershipTrend; List<int> get attendanceTrend; List<int> get taskTrend;
/// Create a copy of MemberAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberAnalyticsCopyWith<MemberAnalytics> get copyWith => _$MemberAnalyticsCopyWithImpl<MemberAnalytics>(this as MemberAnalytics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberAnalytics&&const DeepCollectionEquality().equals(other.leadershipTrend, leadershipTrend)&&const DeepCollectionEquality().equals(other.attendanceTrend, attendanceTrend)&&const DeepCollectionEquality().equals(other.taskTrend, taskTrend));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leadershipTrend),const DeepCollectionEquality().hash(attendanceTrend),const DeepCollectionEquality().hash(taskTrend));

@override
String toString() {
  return 'MemberAnalytics(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class $MemberAnalyticsCopyWith<$Res>  {
  factory $MemberAnalyticsCopyWith(MemberAnalytics value, $Res Function(MemberAnalytics) _then) = _$MemberAnalyticsCopyWithImpl;
@useResult
$Res call({
 List<int> leadershipTrend, List<int> attendanceTrend, List<int> taskTrend
});




}
/// @nodoc
class _$MemberAnalyticsCopyWithImpl<$Res>
    implements $MemberAnalyticsCopyWith<$Res> {
  _$MemberAnalyticsCopyWithImpl(this._self, this._then);

  final MemberAnalytics _self;
  final $Res Function(MemberAnalytics) _then;

/// Create a copy of MemberAnalytics
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


/// Adds pattern-matching-related methods to [MemberAnalytics].
extension MemberAnalyticsPatterns on MemberAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _MemberAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _MemberAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> leadershipTrend,  List<int> attendanceTrend,  List<int> taskTrend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberAnalytics() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> leadershipTrend,  List<int> attendanceTrend,  List<int> taskTrend)  $default,) {final _that = this;
switch (_that) {
case _MemberAnalytics():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> leadershipTrend,  List<int> attendanceTrend,  List<int> taskTrend)?  $default,) {final _that = this;
switch (_that) {
case _MemberAnalytics() when $default != null:
return $default(_that.leadershipTrend,_that.attendanceTrend,_that.taskTrend);case _:
  return null;

}
}

}

/// @nodoc


class _MemberAnalytics implements MemberAnalytics {
  const _MemberAnalytics({required final  List<int> leadershipTrend, required final  List<int> attendanceTrend, required final  List<int> taskTrend}): _leadershipTrend = leadershipTrend,_attendanceTrend = attendanceTrend,_taskTrend = taskTrend;
  

 final  List<int> _leadershipTrend;
@override List<int> get leadershipTrend {
  if (_leadershipTrend is EqualUnmodifiableListView) return _leadershipTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leadershipTrend);
}

 final  List<int> _attendanceTrend;
@override List<int> get attendanceTrend {
  if (_attendanceTrend is EqualUnmodifiableListView) return _attendanceTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendanceTrend);
}

 final  List<int> _taskTrend;
@override List<int> get taskTrend {
  if (_taskTrend is EqualUnmodifiableListView) return _taskTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taskTrend);
}


/// Create a copy of MemberAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberAnalyticsCopyWith<_MemberAnalytics> get copyWith => __$MemberAnalyticsCopyWithImpl<_MemberAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberAnalytics&&const DeepCollectionEquality().equals(other._leadershipTrend, _leadershipTrend)&&const DeepCollectionEquality().equals(other._attendanceTrend, _attendanceTrend)&&const DeepCollectionEquality().equals(other._taskTrend, _taskTrend));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leadershipTrend),const DeepCollectionEquality().hash(_attendanceTrend),const DeepCollectionEquality().hash(_taskTrend));

@override
String toString() {
  return 'MemberAnalytics(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class _$MemberAnalyticsCopyWith<$Res> implements $MemberAnalyticsCopyWith<$Res> {
  factory _$MemberAnalyticsCopyWith(_MemberAnalytics value, $Res Function(_MemberAnalytics) _then) = __$MemberAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 List<int> leadershipTrend, List<int> attendanceTrend, List<int> taskTrend
});




}
/// @nodoc
class __$MemberAnalyticsCopyWithImpl<$Res>
    implements _$MemberAnalyticsCopyWith<$Res> {
  __$MemberAnalyticsCopyWithImpl(this._self, this._then);

  final _MemberAnalytics _self;
  final $Res Function(_MemberAnalytics) _then;

/// Create a copy of MemberAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipTrend = null,Object? attendanceTrend = null,Object? taskTrend = null,}) {
  return _then(_MemberAnalytics(
leadershipTrend: null == leadershipTrend ? _self._leadershipTrend : leadershipTrend // ignore: cast_nullable_to_non_nullable
as List<int>,attendanceTrend: null == attendanceTrend ? _self._attendanceTrend : attendanceTrend // ignore: cast_nullable_to_non_nullable
as List<int>,taskTrend: null == taskTrend ? _self._taskTrend : taskTrend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
