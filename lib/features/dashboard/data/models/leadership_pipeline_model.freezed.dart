// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leadership_pipeline_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeadershipPipelineModel {

@JsonKey(name: 'future_leaders') List<PipelineMember> get futureLeaders;@JsonKey(name: 'emerging_leaders') List<PipelineMember> get emergingLeaders;@JsonKey(name: 'developing') List<PipelineMember> get developing;@JsonKey(name: 'needs_development') List<PipelineMember> get needsDevelopment;
/// Create a copy of LeadershipPipelineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeadershipPipelineModelCopyWith<LeadershipPipelineModel> get copyWith => _$LeadershipPipelineModelCopyWithImpl<LeadershipPipelineModel>(this as LeadershipPipelineModel, _$identity);

  /// Serializes this LeadershipPipelineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeadershipPipelineModel&&const DeepCollectionEquality().equals(other.futureLeaders, futureLeaders)&&const DeepCollectionEquality().equals(other.emergingLeaders, emergingLeaders)&&const DeepCollectionEquality().equals(other.developing, developing)&&const DeepCollectionEquality().equals(other.needsDevelopment, needsDevelopment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(futureLeaders),const DeepCollectionEquality().hash(emergingLeaders),const DeepCollectionEquality().hash(developing),const DeepCollectionEquality().hash(needsDevelopment));

@override
String toString() {
  return 'LeadershipPipelineModel(futureLeaders: $futureLeaders, emergingLeaders: $emergingLeaders, developing: $developing, needsDevelopment: $needsDevelopment)';
}


}

/// @nodoc
abstract mixin class $LeadershipPipelineModelCopyWith<$Res>  {
  factory $LeadershipPipelineModelCopyWith(LeadershipPipelineModel value, $Res Function(LeadershipPipelineModel) _then) = _$LeadershipPipelineModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'future_leaders') List<PipelineMember> futureLeaders,@JsonKey(name: 'emerging_leaders') List<PipelineMember> emergingLeaders,@JsonKey(name: 'developing') List<PipelineMember> developing,@JsonKey(name: 'needs_development') List<PipelineMember> needsDevelopment
});




}
/// @nodoc
class _$LeadershipPipelineModelCopyWithImpl<$Res>
    implements $LeadershipPipelineModelCopyWith<$Res> {
  _$LeadershipPipelineModelCopyWithImpl(this._self, this._then);

  final LeadershipPipelineModel _self;
  final $Res Function(LeadershipPipelineModel) _then;

/// Create a copy of LeadershipPipelineModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? futureLeaders = null,Object? emergingLeaders = null,Object? developing = null,Object? needsDevelopment = null,}) {
  return _then(_self.copyWith(
futureLeaders: null == futureLeaders ? _self.futureLeaders : futureLeaders // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,emergingLeaders: null == emergingLeaders ? _self.emergingLeaders : emergingLeaders // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,developing: null == developing ? _self.developing : developing // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,needsDevelopment: null == needsDevelopment ? _self.needsDevelopment : needsDevelopment // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeadershipPipelineModel].
extension LeadershipPipelineModelPatterns on LeadershipPipelineModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeadershipPipelineModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeadershipPipelineModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeadershipPipelineModel value)  $default,){
final _that = this;
switch (_that) {
case _LeadershipPipelineModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeadershipPipelineModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeadershipPipelineModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'future_leaders')  List<PipelineMember> futureLeaders, @JsonKey(name: 'emerging_leaders')  List<PipelineMember> emergingLeaders, @JsonKey(name: 'developing')  List<PipelineMember> developing, @JsonKey(name: 'needs_development')  List<PipelineMember> needsDevelopment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeadershipPipelineModel() when $default != null:
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'future_leaders')  List<PipelineMember> futureLeaders, @JsonKey(name: 'emerging_leaders')  List<PipelineMember> emergingLeaders, @JsonKey(name: 'developing')  List<PipelineMember> developing, @JsonKey(name: 'needs_development')  List<PipelineMember> needsDevelopment)  $default,) {final _that = this;
switch (_that) {
case _LeadershipPipelineModel():
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'future_leaders')  List<PipelineMember> futureLeaders, @JsonKey(name: 'emerging_leaders')  List<PipelineMember> emergingLeaders, @JsonKey(name: 'developing')  List<PipelineMember> developing, @JsonKey(name: 'needs_development')  List<PipelineMember> needsDevelopment)?  $default,) {final _that = this;
switch (_that) {
case _LeadershipPipelineModel() when $default != null:
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeadershipPipelineModel implements LeadershipPipelineModel {
  const _LeadershipPipelineModel({@JsonKey(name: 'future_leaders') final  List<PipelineMember> futureLeaders = const [], @JsonKey(name: 'emerging_leaders') final  List<PipelineMember> emergingLeaders = const [], @JsonKey(name: 'developing') final  List<PipelineMember> developing = const [], @JsonKey(name: 'needs_development') final  List<PipelineMember> needsDevelopment = const []}): _futureLeaders = futureLeaders,_emergingLeaders = emergingLeaders,_developing = developing,_needsDevelopment = needsDevelopment;
  factory _LeadershipPipelineModel.fromJson(Map<String, dynamic> json) => _$LeadershipPipelineModelFromJson(json);

 final  List<PipelineMember> _futureLeaders;
@override@JsonKey(name: 'future_leaders') List<PipelineMember> get futureLeaders {
  if (_futureLeaders is EqualUnmodifiableListView) return _futureLeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_futureLeaders);
}

 final  List<PipelineMember> _emergingLeaders;
@override@JsonKey(name: 'emerging_leaders') List<PipelineMember> get emergingLeaders {
  if (_emergingLeaders is EqualUnmodifiableListView) return _emergingLeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emergingLeaders);
}

 final  List<PipelineMember> _developing;
@override@JsonKey(name: 'developing') List<PipelineMember> get developing {
  if (_developing is EqualUnmodifiableListView) return _developing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_developing);
}

 final  List<PipelineMember> _needsDevelopment;
@override@JsonKey(name: 'needs_development') List<PipelineMember> get needsDevelopment {
  if (_needsDevelopment is EqualUnmodifiableListView) return _needsDevelopment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_needsDevelopment);
}


/// Create a copy of LeadershipPipelineModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeadershipPipelineModelCopyWith<_LeadershipPipelineModel> get copyWith => __$LeadershipPipelineModelCopyWithImpl<_LeadershipPipelineModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeadershipPipelineModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeadershipPipelineModel&&const DeepCollectionEquality().equals(other._futureLeaders, _futureLeaders)&&const DeepCollectionEquality().equals(other._emergingLeaders, _emergingLeaders)&&const DeepCollectionEquality().equals(other._developing, _developing)&&const DeepCollectionEquality().equals(other._needsDevelopment, _needsDevelopment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_futureLeaders),const DeepCollectionEquality().hash(_emergingLeaders),const DeepCollectionEquality().hash(_developing),const DeepCollectionEquality().hash(_needsDevelopment));

@override
String toString() {
  return 'LeadershipPipelineModel(futureLeaders: $futureLeaders, emergingLeaders: $emergingLeaders, developing: $developing, needsDevelopment: $needsDevelopment)';
}


}

/// @nodoc
abstract mixin class _$LeadershipPipelineModelCopyWith<$Res> implements $LeadershipPipelineModelCopyWith<$Res> {
  factory _$LeadershipPipelineModelCopyWith(_LeadershipPipelineModel value, $Res Function(_LeadershipPipelineModel) _then) = __$LeadershipPipelineModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'future_leaders') List<PipelineMember> futureLeaders,@JsonKey(name: 'emerging_leaders') List<PipelineMember> emergingLeaders,@JsonKey(name: 'developing') List<PipelineMember> developing,@JsonKey(name: 'needs_development') List<PipelineMember> needsDevelopment
});




}
/// @nodoc
class __$LeadershipPipelineModelCopyWithImpl<$Res>
    implements _$LeadershipPipelineModelCopyWith<$Res> {
  __$LeadershipPipelineModelCopyWithImpl(this._self, this._then);

  final _LeadershipPipelineModel _self;
  final $Res Function(_LeadershipPipelineModel) _then;

/// Create a copy of LeadershipPipelineModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? futureLeaders = null,Object? emergingLeaders = null,Object? developing = null,Object? needsDevelopment = null,}) {
  return _then(_LeadershipPipelineModel(
futureLeaders: null == futureLeaders ? _self._futureLeaders : futureLeaders // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,emergingLeaders: null == emergingLeaders ? _self._emergingLeaders : emergingLeaders // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,developing: null == developing ? _self._developing : developing // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,needsDevelopment: null == needsDevelopment ? _self._needsDevelopment : needsDevelopment // ignore: cast_nullable_to_non_nullable
as List<PipelineMember>,
  ));
}


}


/// @nodoc
mixin _$PipelineMember {

@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'leadership_score') double get leadershipScore;@JsonKey(name: 'leadership_band') String get leadershipBand;@JsonKey(name: 'company_percentile') double? get companyPercentile;@JsonKey(name: 'attendance_delta_30d') double? get attendanceDelta30d;@JsonKey(name: 'task_delta_30d') double? get taskDelta30d;
/// Create a copy of PipelineMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineMemberCopyWith<PipelineMember> get copyWith => _$PipelineMemberCopyWithImpl<PipelineMember>(this as PipelineMember, _$identity);

  /// Serializes this PipelineMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineMember&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.leadershipBand, leadershipBand) || other.leadershipBand == leadershipBand)&&(identical(other.companyPercentile, companyPercentile) || other.companyPercentile == companyPercentile)&&(identical(other.attendanceDelta30d, attendanceDelta30d) || other.attendanceDelta30d == attendanceDelta30d)&&(identical(other.taskDelta30d, taskDelta30d) || other.taskDelta30d == taskDelta30d));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,leadershipScore,leadershipBand,companyPercentile,attendanceDelta30d,taskDelta30d);

@override
String toString() {
  return 'PipelineMember(firstName: $firstName, lastName: $lastName, leadershipScore: $leadershipScore, leadershipBand: $leadershipBand, companyPercentile: $companyPercentile, attendanceDelta30d: $attendanceDelta30d, taskDelta30d: $taskDelta30d)';
}


}

/// @nodoc
abstract mixin class $PipelineMemberCopyWith<$Res>  {
  factory $PipelineMemberCopyWith(PipelineMember value, $Res Function(PipelineMember) _then) = _$PipelineMemberCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'leadership_score') double leadershipScore,@JsonKey(name: 'leadership_band') String leadershipBand,@JsonKey(name: 'company_percentile') double? companyPercentile,@JsonKey(name: 'attendance_delta_30d') double? attendanceDelta30d,@JsonKey(name: 'task_delta_30d') double? taskDelta30d
});




}
/// @nodoc
class _$PipelineMemberCopyWithImpl<$Res>
    implements $PipelineMemberCopyWith<$Res> {
  _$PipelineMemberCopyWithImpl(this._self, this._then);

  final PipelineMember _self;
  final $Res Function(PipelineMember) _then;

/// Create a copy of PipelineMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? leadershipScore = null,Object? leadershipBand = null,Object? companyPercentile = freezed,Object? attendanceDelta30d = freezed,Object? taskDelta30d = freezed,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as double,leadershipBand: null == leadershipBand ? _self.leadershipBand : leadershipBand // ignore: cast_nullable_to_non_nullable
as String,companyPercentile: freezed == companyPercentile ? _self.companyPercentile : companyPercentile // ignore: cast_nullable_to_non_nullable
as double?,attendanceDelta30d: freezed == attendanceDelta30d ? _self.attendanceDelta30d : attendanceDelta30d // ignore: cast_nullable_to_non_nullable
as double?,taskDelta30d: freezed == taskDelta30d ? _self.taskDelta30d : taskDelta30d // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineMember].
extension PipelineMemberPatterns on PipelineMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineMember value)  $default,){
final _that = this;
switch (_that) {
case _PipelineMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineMember value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'leadership_score')  double leadershipScore, @JsonKey(name: 'leadership_band')  String leadershipBand, @JsonKey(name: 'company_percentile')  double? companyPercentile, @JsonKey(name: 'attendance_delta_30d')  double? attendanceDelta30d, @JsonKey(name: 'task_delta_30d')  double? taskDelta30d)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineMember() when $default != null:
return $default(_that.firstName,_that.lastName,_that.leadershipScore,_that.leadershipBand,_that.companyPercentile,_that.attendanceDelta30d,_that.taskDelta30d);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'leadership_score')  double leadershipScore, @JsonKey(name: 'leadership_band')  String leadershipBand, @JsonKey(name: 'company_percentile')  double? companyPercentile, @JsonKey(name: 'attendance_delta_30d')  double? attendanceDelta30d, @JsonKey(name: 'task_delta_30d')  double? taskDelta30d)  $default,) {final _that = this;
switch (_that) {
case _PipelineMember():
return $default(_that.firstName,_that.lastName,_that.leadershipScore,_that.leadershipBand,_that.companyPercentile,_that.attendanceDelta30d,_that.taskDelta30d);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'leadership_score')  double leadershipScore, @JsonKey(name: 'leadership_band')  String leadershipBand, @JsonKey(name: 'company_percentile')  double? companyPercentile, @JsonKey(name: 'attendance_delta_30d')  double? attendanceDelta30d, @JsonKey(name: 'task_delta_30d')  double? taskDelta30d)?  $default,) {final _that = this;
switch (_that) {
case _PipelineMember() when $default != null:
return $default(_that.firstName,_that.lastName,_that.leadershipScore,_that.leadershipBand,_that.companyPercentile,_that.attendanceDelta30d,_that.taskDelta30d);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineMember extends PipelineMember {
  const _PipelineMember({@JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'leadership_score') required this.leadershipScore, @JsonKey(name: 'leadership_band') required this.leadershipBand, @JsonKey(name: 'company_percentile') this.companyPercentile, @JsonKey(name: 'attendance_delta_30d') this.attendanceDelta30d, @JsonKey(name: 'task_delta_30d') this.taskDelta30d}): super._();
  factory _PipelineMember.fromJson(Map<String, dynamic> json) => _$PipelineMemberFromJson(json);

@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'leadership_score') final  double leadershipScore;
@override@JsonKey(name: 'leadership_band') final  String leadershipBand;
@override@JsonKey(name: 'company_percentile') final  double? companyPercentile;
@override@JsonKey(name: 'attendance_delta_30d') final  double? attendanceDelta30d;
@override@JsonKey(name: 'task_delta_30d') final  double? taskDelta30d;

/// Create a copy of PipelineMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineMemberCopyWith<_PipelineMember> get copyWith => __$PipelineMemberCopyWithImpl<_PipelineMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineMember&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.leadershipScore, leadershipScore) || other.leadershipScore == leadershipScore)&&(identical(other.leadershipBand, leadershipBand) || other.leadershipBand == leadershipBand)&&(identical(other.companyPercentile, companyPercentile) || other.companyPercentile == companyPercentile)&&(identical(other.attendanceDelta30d, attendanceDelta30d) || other.attendanceDelta30d == attendanceDelta30d)&&(identical(other.taskDelta30d, taskDelta30d) || other.taskDelta30d == taskDelta30d));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,leadershipScore,leadershipBand,companyPercentile,attendanceDelta30d,taskDelta30d);

@override
String toString() {
  return 'PipelineMember(firstName: $firstName, lastName: $lastName, leadershipScore: $leadershipScore, leadershipBand: $leadershipBand, companyPercentile: $companyPercentile, attendanceDelta30d: $attendanceDelta30d, taskDelta30d: $taskDelta30d)';
}


}

/// @nodoc
abstract mixin class _$PipelineMemberCopyWith<$Res> implements $PipelineMemberCopyWith<$Res> {
  factory _$PipelineMemberCopyWith(_PipelineMember value, $Res Function(_PipelineMember) _then) = __$PipelineMemberCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'leadership_score') double leadershipScore,@JsonKey(name: 'leadership_band') String leadershipBand,@JsonKey(name: 'company_percentile') double? companyPercentile,@JsonKey(name: 'attendance_delta_30d') double? attendanceDelta30d,@JsonKey(name: 'task_delta_30d') double? taskDelta30d
});




}
/// @nodoc
class __$PipelineMemberCopyWithImpl<$Res>
    implements _$PipelineMemberCopyWith<$Res> {
  __$PipelineMemberCopyWithImpl(this._self, this._then);

  final _PipelineMember _self;
  final $Res Function(_PipelineMember) _then;

/// Create a copy of PipelineMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? leadershipScore = null,Object? leadershipBand = null,Object? companyPercentile = freezed,Object? attendanceDelta30d = freezed,Object? taskDelta30d = freezed,}) {
  return _then(_PipelineMember(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,leadershipScore: null == leadershipScore ? _self.leadershipScore : leadershipScore // ignore: cast_nullable_to_non_nullable
as double,leadershipBand: null == leadershipBand ? _self.leadershipBand : leadershipBand // ignore: cast_nullable_to_non_nullable
as String,companyPercentile: freezed == companyPercentile ? _self.companyPercentile : companyPercentile // ignore: cast_nullable_to_non_nullable
as double?,attendanceDelta30d: freezed == attendanceDelta30d ? _self.attendanceDelta30d : attendanceDelta30d // ignore: cast_nullable_to_non_nullable
as double?,taskDelta30d: freezed == taskDelta30d ? _self.taskDelta30d : taskDelta30d // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
