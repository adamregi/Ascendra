// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_profile_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberProfileViewModel {

 int get version;@JsonKey(name: 'generated_at') DateTime get generatedAt; MemberHeroModel get hero; MemberOverviewModel get overview; MemberComplianceModel get compliance; List<MemberTimelineEventModel> get timeline; List<MemberRecognitionModel> get recognition; MemberAnalyticsModel get analytics;
/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileViewModelCopyWith<MemberProfileViewModel> get copyWith => _$MemberProfileViewModelCopyWithImpl<MemberProfileViewModel>(this as MemberProfileViewModel, _$identity);

  /// Serializes this MemberProfileViewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileViewModel&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.recognition, recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generatedAt,hero,overview,compliance,const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(recognition),analytics);

@override
String toString() {
  return 'MemberProfileViewModel(version: $version, generatedAt: $generatedAt, hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class $MemberProfileViewModelCopyWith<$Res>  {
  factory $MemberProfileViewModelCopyWith(MemberProfileViewModel value, $Res Function(MemberProfileViewModel) _then) = _$MemberProfileViewModelCopyWithImpl;
@useResult
$Res call({
 int version,@JsonKey(name: 'generated_at') DateTime generatedAt, MemberHeroModel hero, MemberOverviewModel overview, MemberComplianceModel compliance, List<MemberTimelineEventModel> timeline, List<MemberRecognitionModel> recognition, MemberAnalyticsModel analytics
});


$MemberHeroModelCopyWith<$Res> get hero;$MemberOverviewModelCopyWith<$Res> get overview;$MemberComplianceModelCopyWith<$Res> get compliance;$MemberAnalyticsModelCopyWith<$Res> get analytics;

}
/// @nodoc
class _$MemberProfileViewModelCopyWithImpl<$Res>
    implements $MemberProfileViewModelCopyWith<$Res> {
  _$MemberProfileViewModelCopyWithImpl(this._self, this._then);

  final MemberProfileViewModel _self;
  final $Res Function(MemberProfileViewModel) _then;

/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? generatedAt = null,Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberHeroModel,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberOverviewModel,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberComplianceModel,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberTimelineEventModel>,recognition: null == recognition ? _self.recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberRecognitionModel>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberAnalyticsModel,
  ));
}
/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberHeroModelCopyWith<$Res> get hero {
  
  return $MemberHeroModelCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberOverviewModelCopyWith<$Res> get overview {
  
  return $MemberOverviewModelCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberComplianceModelCopyWith<$Res> get compliance {
  
  return $MemberComplianceModelCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberAnalyticsModelCopyWith<$Res> get analytics {
  
  return $MemberAnalyticsModelCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberProfileViewModel].
extension MemberProfileViewModelPatterns on MemberProfileViewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileViewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileViewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileViewModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileViewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileViewModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileViewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberHeroModel hero,  MemberOverviewModel overview,  MemberComplianceModel compliance,  List<MemberTimelineEventModel> timeline,  List<MemberRecognitionModel> recognition,  MemberAnalyticsModel analytics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileViewModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberHeroModel hero,  MemberOverviewModel overview,  MemberComplianceModel compliance,  List<MemberTimelineEventModel> timeline,  List<MemberRecognitionModel> recognition,  MemberAnalyticsModel analytics)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileViewModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version, @JsonKey(name: 'generated_at')  DateTime generatedAt,  MemberHeroModel hero,  MemberOverviewModel overview,  MemberComplianceModel compliance,  List<MemberTimelineEventModel> timeline,  List<MemberRecognitionModel> recognition,  MemberAnalyticsModel analytics)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileViewModel() when $default != null:
return $default(_that.version,_that.generatedAt,_that.hero,_that.overview,_that.compliance,_that.timeline,_that.recognition,_that.analytics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileViewModel implements MemberProfileViewModel {
  const _MemberProfileViewModel({required this.version, @JsonKey(name: 'generated_at') required this.generatedAt, required this.hero, required this.overview, required this.compliance, required final  List<MemberTimelineEventModel> timeline, required final  List<MemberRecognitionModel> recognition, required this.analytics}): _timeline = timeline,_recognition = recognition;
  factory _MemberProfileViewModel.fromJson(Map<String, dynamic> json) => _$MemberProfileViewModelFromJson(json);

@override final  int version;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
@override final  MemberHeroModel hero;
@override final  MemberOverviewModel overview;
@override final  MemberComplianceModel compliance;
 final  List<MemberTimelineEventModel> _timeline;
@override List<MemberTimelineEventModel> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<MemberRecognitionModel> _recognition;
@override List<MemberRecognitionModel> get recognition {
  if (_recognition is EqualUnmodifiableListView) return _recognition;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognition);
}

@override final  MemberAnalyticsModel analytics;

/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileViewModelCopyWith<_MemberProfileViewModel> get copyWith => __$MemberProfileViewModelCopyWithImpl<_MemberProfileViewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileViewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileViewModel&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._recognition, _recognition)&&(identical(other.analytics, analytics) || other.analytics == analytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,generatedAt,hero,overview,compliance,const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_recognition),analytics);

@override
String toString() {
  return 'MemberProfileViewModel(version: $version, generatedAt: $generatedAt, hero: $hero, overview: $overview, compliance: $compliance, timeline: $timeline, recognition: $recognition, analytics: $analytics)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileViewModelCopyWith<$Res> implements $MemberProfileViewModelCopyWith<$Res> {
  factory _$MemberProfileViewModelCopyWith(_MemberProfileViewModel value, $Res Function(_MemberProfileViewModel) _then) = __$MemberProfileViewModelCopyWithImpl;
@override @useResult
$Res call({
 int version,@JsonKey(name: 'generated_at') DateTime generatedAt, MemberHeroModel hero, MemberOverviewModel overview, MemberComplianceModel compliance, List<MemberTimelineEventModel> timeline, List<MemberRecognitionModel> recognition, MemberAnalyticsModel analytics
});


@override $MemberHeroModelCopyWith<$Res> get hero;@override $MemberOverviewModelCopyWith<$Res> get overview;@override $MemberComplianceModelCopyWith<$Res> get compliance;@override $MemberAnalyticsModelCopyWith<$Res> get analytics;

}
/// @nodoc
class __$MemberProfileViewModelCopyWithImpl<$Res>
    implements _$MemberProfileViewModelCopyWith<$Res> {
  __$MemberProfileViewModelCopyWithImpl(this._self, this._then);

  final _MemberProfileViewModel _self;
  final $Res Function(_MemberProfileViewModel) _then;

/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? generatedAt = null,Object? hero = null,Object? overview = null,Object? compliance = null,Object? timeline = null,Object? recognition = null,Object? analytics = null,}) {
  return _then(_MemberProfileViewModel(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as MemberHeroModel,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as MemberOverviewModel,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as MemberComplianceModel,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<MemberTimelineEventModel>,recognition: null == recognition ? _self._recognition : recognition // ignore: cast_nullable_to_non_nullable
as List<MemberRecognitionModel>,analytics: null == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as MemberAnalyticsModel,
  ));
}

/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberHeroModelCopyWith<$Res> get hero {
  
  return $MemberHeroModelCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberOverviewModelCopyWith<$Res> get overview {
  
  return $MemberOverviewModelCopyWith<$Res>(_self.overview, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberComplianceModelCopyWith<$Res> get compliance {
  
  return $MemberComplianceModelCopyWith<$Res>(_self.compliance, (value) {
    return _then(_self.copyWith(compliance: value));
  });
}/// Create a copy of MemberProfileViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberAnalyticsModelCopyWith<$Res> get analytics {
  
  return $MemberAnalyticsModelCopyWith<$Res>(_self.analytics, (value) {
    return _then(_self.copyWith(analytics: value));
  });
}
}


/// @nodoc
mixin _$MemberHeroModel {

@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'distributor_id') String get distributorId;@JsonKey(name: 'leader_name') String? get leaderName; String get rank; String get status;@JsonKey(name: 'joined_date') DateTime get joinedDate;@JsonKey(name: 'current_streak') int get currentStreak;
/// Create a copy of MemberHeroModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberHeroModelCopyWith<MemberHeroModel> get copyWith => _$MemberHeroModelCopyWithImpl<MemberHeroModel>(this as MemberHeroModel, _$identity);

  /// Serializes this MemberHeroModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberHeroModel&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberHeroModel(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class $MemberHeroModelCopyWith<$Res>  {
  factory $MemberHeroModelCopyWith(MemberHeroModel value, $Res Function(MemberHeroModel) _then) = _$MemberHeroModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'distributor_id') String distributorId,@JsonKey(name: 'leader_name') String? leaderName, String rank, String status,@JsonKey(name: 'joined_date') DateTime joinedDate,@JsonKey(name: 'current_streak') int currentStreak
});




}
/// @nodoc
class _$MemberHeroModelCopyWithImpl<$Res>
    implements $MemberHeroModelCopyWith<$Res> {
  _$MemberHeroModelCopyWithImpl(this._self, this._then);

  final MemberHeroModel _self;
  final $Res Function(MemberHeroModel) _then;

/// Create a copy of MemberHeroModel
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


/// Adds pattern-matching-related methods to [MemberHeroModel].
extension MemberHeroModelPatterns on MemberHeroModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberHeroModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberHeroModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberHeroModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberHeroModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberHeroModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberHeroModel() when $default != null:
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
case _MemberHeroModel() when $default != null:
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
case _MemberHeroModel():
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
case _MemberHeroModel() when $default != null:
return $default(_that.avatarUrl,_that.firstName,_that.lastName,_that.distributorId,_that.leaderName,_that.rank,_that.status,_that.joinedDate,_that.currentStreak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberHeroModel implements MemberHeroModel {
  const _MemberHeroModel({@JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'distributor_id') required this.distributorId, @JsonKey(name: 'leader_name') this.leaderName, required this.rank, required this.status, @JsonKey(name: 'joined_date') required this.joinedDate, @JsonKey(name: 'current_streak') required this.currentStreak});
  factory _MemberHeroModel.fromJson(Map<String, dynamic> json) => _$MemberHeroModelFromJson(json);

@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'distributor_id') final  String distributorId;
@override@JsonKey(name: 'leader_name') final  String? leaderName;
@override final  String rank;
@override final  String status;
@override@JsonKey(name: 'joined_date') final  DateTime joinedDate;
@override@JsonKey(name: 'current_streak') final  int currentStreak;

/// Create a copy of MemberHeroModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberHeroModelCopyWith<_MemberHeroModel> get copyWith => __$MemberHeroModelCopyWithImpl<_MemberHeroModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberHeroModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberHeroModel&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.distributorId, distributorId) || other.distributorId == distributorId)&&(identical(other.leaderName, leaderName) || other.leaderName == leaderName)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatarUrl,firstName,lastName,distributorId,leaderName,rank,status,joinedDate,currentStreak);

@override
String toString() {
  return 'MemberHeroModel(avatarUrl: $avatarUrl, firstName: $firstName, lastName: $lastName, distributorId: $distributorId, leaderName: $leaderName, rank: $rank, status: $status, joinedDate: $joinedDate, currentStreak: $currentStreak)';
}


}

/// @nodoc
abstract mixin class _$MemberHeroModelCopyWith<$Res> implements $MemberHeroModelCopyWith<$Res> {
  factory _$MemberHeroModelCopyWith(_MemberHeroModel value, $Res Function(_MemberHeroModel) _then) = __$MemberHeroModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'distributor_id') String distributorId,@JsonKey(name: 'leader_name') String? leaderName, String rank, String status,@JsonKey(name: 'joined_date') DateTime joinedDate,@JsonKey(name: 'current_streak') int currentStreak
});




}
/// @nodoc
class __$MemberHeroModelCopyWithImpl<$Res>
    implements _$MemberHeroModelCopyWith<$Res> {
  __$MemberHeroModelCopyWithImpl(this._self, this._then);

  final _MemberHeroModel _self;
  final $Res Function(_MemberHeroModel) _then;

/// Create a copy of MemberHeroModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatarUrl = freezed,Object? firstName = null,Object? lastName = null,Object? distributorId = null,Object? leaderName = freezed,Object? rank = null,Object? status = null,Object? joinedDate = null,Object? currentStreak = null,}) {
  return _then(_MemberHeroModel(
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
mixin _$MemberOverviewModel {

@JsonKey(name: 'leadership_score') int get leadershipScore;@JsonKey(name: 'recognition_count') int get recognitionCount;@JsonKey(name: 'compliance_score') int get complianceScore;@JsonKey(name: 'meeting_percent') int get meetingPercent;@JsonKey(name: 'task_percent') int get taskPercent;@JsonKey(name: 'risk_level') String get riskLevel;
/// Create a copy of MemberOverviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberOverviewModelCopyWith<MemberOverviewModel> get copyWith => _$MemberOverviewModelCopyWithImpl<MemberOverviewModel>(this as MemberOverviewModel, _$identity);

  /// Serializes this MemberOverviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberOverviewModel&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberOverviewModel(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $MemberOverviewModelCopyWith<$Res>  {
  factory $MemberOverviewModelCopyWith(MemberOverviewModel value, $Res Function(MemberOverviewModel) _then) = _$MemberOverviewModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leadership_score') int leadershipScore,@JsonKey(name: 'recognition_count') int recognitionCount,@JsonKey(name: 'compliance_score') int complianceScore,@JsonKey(name: 'meeting_percent') int meetingPercent,@JsonKey(name: 'task_percent') int taskPercent,@JsonKey(name: 'risk_level') String riskLevel
});




}
/// @nodoc
class _$MemberOverviewModelCopyWithImpl<$Res>
    implements $MemberOverviewModelCopyWith<$Res> {
  _$MemberOverviewModelCopyWithImpl(this._self, this._then);

  final MemberOverviewModel _self;
  final $Res Function(MemberOverviewModel) _then;

/// Create a copy of MemberOverviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leadershipScore = null,Object? recognitionCount = null,Object? complianceScore = null,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,}) {
  return _then(_self.copyWith(
leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,complianceScore: null == complianceScore ? _self.complianceScore : complianceScore // ignore: cast_nullable_to_non_nullable
as int,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as int,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberOverviewModel].
extension MemberOverviewModelPatterns on MemberOverviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberOverviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberOverviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberOverviewModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberOverviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberOverviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberOverviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberOverviewModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)  $default,) {final _that = this;
switch (_that) {
case _MemberOverviewModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leadership_score')  int leadershipScore, @JsonKey(name: 'recognition_count')  int recognitionCount, @JsonKey(name: 'compliance_score')  int complianceScore, @JsonKey(name: 'meeting_percent')  int meetingPercent, @JsonKey(name: 'task_percent')  int taskPercent, @JsonKey(name: 'risk_level')  String riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _MemberOverviewModel() when $default != null:
return $default(_that.leadershipScore,_that.recognitionCount,_that.complianceScore,_that.meetingPercent,_that.taskPercent,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberOverviewModel implements MemberOverviewModel {
  const _MemberOverviewModel({@JsonKey(name: 'leadership_score') required this.leadershipScore, @JsonKey(name: 'recognition_count') required this.recognitionCount, @JsonKey(name: 'compliance_score') required this.complianceScore, @JsonKey(name: 'meeting_percent') required this.meetingPercent, @JsonKey(name: 'task_percent') required this.taskPercent, @JsonKey(name: 'risk_level') required this.riskLevel});
  factory _MemberOverviewModel.fromJson(Map<String, dynamic> json) => _$MemberOverviewModelFromJson(json);

@override@JsonKey(name: 'leadership_score') final  int leadershipScore;
@override@JsonKey(name: 'recognition_count') final  int recognitionCount;
@override@JsonKey(name: 'compliance_score') final  int complianceScore;
@override@JsonKey(name: 'meeting_percent') final  int meetingPercent;
@override@JsonKey(name: 'task_percent') final  int taskPercent;
@override@JsonKey(name: 'risk_level') final  String riskLevel;

/// Create a copy of MemberOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberOverviewModelCopyWith<_MemberOverviewModel> get copyWith => __$MemberOverviewModelCopyWithImpl<_MemberOverviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberOverviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberOverviewModel&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount)&&(identical(other.complianceScore, complianceScore) || other.complianceScore == complianceScore)&&(identical(other.meetingPercent, meetingPercent) || other.meetingPercent == meetingPercent)&&(identical(other.taskPercent, taskPercent) || other.taskPercent == taskPercent)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leadershipScore,recognitionCount,complianceScore,meetingPercent,taskPercent,riskLevel);

@override
String toString() {
  return 'MemberOverviewModel(leadershipScore: $leadershipScore, recognitionCount: $recognitionCount, complianceScore: $complianceScore, meetingPercent: $meetingPercent, taskPercent: $taskPercent, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$MemberOverviewModelCopyWith<$Res> implements $MemberOverviewModelCopyWith<$Res> {
  factory _$MemberOverviewModelCopyWith(_MemberOverviewModel value, $Res Function(_MemberOverviewModel) _then) = __$MemberOverviewModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leadership_score') int leadershipScore,@JsonKey(name: 'recognition_count') int recognitionCount,@JsonKey(name: 'compliance_score') int complianceScore,@JsonKey(name: 'meeting_percent') int meetingPercent,@JsonKey(name: 'task_percent') int taskPercent,@JsonKey(name: 'risk_level') String riskLevel
});




}
/// @nodoc
class __$MemberOverviewModelCopyWithImpl<$Res>
    implements _$MemberOverviewModelCopyWith<$Res> {
  __$MemberOverviewModelCopyWithImpl(this._self, this._then);

  final _MemberOverviewModel _self;
  final $Res Function(_MemberOverviewModel) _then;

/// Create a copy of MemberOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipScore = null,Object? recognitionCount = null,Object? complianceScore = null,Object? meetingPercent = null,Object? taskPercent = null,Object? riskLevel = null,}) {
  return _then(_MemberOverviewModel(
leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,complianceScore: null == complianceScore ? _self.complianceScore : complianceScore // ignore: cast_nullable_to_non_nullable
as int,meetingPercent: null == meetingPercent ? _self.meetingPercent : meetingPercent // ignore: cast_nullable_to_non_nullable
as int,taskPercent: null == taskPercent ? _self.taskPercent : taskPercent // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MemberComplianceModel {

 int get score; List<String> get reasons;@JsonKey(name: 'next_improvement') String get nextImprovement;
/// Create a copy of MemberComplianceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberComplianceModelCopyWith<MemberComplianceModel> get copyWith => _$MemberComplianceModelCopyWithImpl<MemberComplianceModel>(this as MemberComplianceModel, _$identity);

  /// Serializes this MemberComplianceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberComplianceModel&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(reasons),nextImprovement);

@override
String toString() {
  return 'MemberComplianceModel(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class $MemberComplianceModelCopyWith<$Res>  {
  factory $MemberComplianceModelCopyWith(MemberComplianceModel value, $Res Function(MemberComplianceModel) _then) = _$MemberComplianceModelCopyWithImpl;
@useResult
$Res call({
 int score, List<String> reasons,@JsonKey(name: 'next_improvement') String nextImprovement
});




}
/// @nodoc
class _$MemberComplianceModelCopyWithImpl<$Res>
    implements $MemberComplianceModelCopyWith<$Res> {
  _$MemberComplianceModelCopyWithImpl(this._self, this._then);

  final MemberComplianceModel _self;
  final $Res Function(MemberComplianceModel) _then;

/// Create a copy of MemberComplianceModel
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


/// Adds pattern-matching-related methods to [MemberComplianceModel].
extension MemberComplianceModelPatterns on MemberComplianceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberComplianceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberComplianceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberComplianceModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberComplianceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberComplianceModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberComplianceModel() when $default != null:
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
case _MemberComplianceModel() when $default != null:
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
case _MemberComplianceModel():
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
case _MemberComplianceModel() when $default != null:
return $default(_that.score,_that.reasons,_that.nextImprovement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberComplianceModel implements MemberComplianceModel {
  const _MemberComplianceModel({required this.score, required final  List<String> reasons, @JsonKey(name: 'next_improvement') required this.nextImprovement}): _reasons = reasons;
  factory _MemberComplianceModel.fromJson(Map<String, dynamic> json) => _$MemberComplianceModelFromJson(json);

@override final  int score;
 final  List<String> _reasons;
@override List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override@JsonKey(name: 'next_improvement') final  String nextImprovement;

/// Create a copy of MemberComplianceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberComplianceModelCopyWith<_MemberComplianceModel> get copyWith => __$MemberComplianceModelCopyWithImpl<_MemberComplianceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberComplianceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberComplianceModel&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.nextImprovement, nextImprovement) || other.nextImprovement == nextImprovement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_reasons),nextImprovement);

@override
String toString() {
  return 'MemberComplianceModel(score: $score, reasons: $reasons, nextImprovement: $nextImprovement)';
}


}

/// @nodoc
abstract mixin class _$MemberComplianceModelCopyWith<$Res> implements $MemberComplianceModelCopyWith<$Res> {
  factory _$MemberComplianceModelCopyWith(_MemberComplianceModel value, $Res Function(_MemberComplianceModel) _then) = __$MemberComplianceModelCopyWithImpl;
@override @useResult
$Res call({
 int score, List<String> reasons,@JsonKey(name: 'next_improvement') String nextImprovement
});




}
/// @nodoc
class __$MemberComplianceModelCopyWithImpl<$Res>
    implements _$MemberComplianceModelCopyWith<$Res> {
  __$MemberComplianceModelCopyWithImpl(this._self, this._then);

  final _MemberComplianceModel _self;
  final $Res Function(_MemberComplianceModel) _then;

/// Create a copy of MemberComplianceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? reasons = null,Object? nextImprovement = null,}) {
  return _then(_MemberComplianceModel(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,nextImprovement: null == nextImprovement ? _self.nextImprovement : nextImprovement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
