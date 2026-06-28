// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_analytics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberAnalyticsModel {

@JsonKey(name: 'leadership_trend') List<int> get leadershipTrend;@JsonKey(name: 'attendance_trend') List<int> get attendanceTrend;@JsonKey(name: 'task_trend') List<int> get taskTrend;
/// Create a copy of MemberAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberAnalyticsModelCopyWith<MemberAnalyticsModel> get copyWith => _$MemberAnalyticsModelCopyWithImpl<MemberAnalyticsModel>(this as MemberAnalyticsModel, _$identity);

  /// Serializes this MemberAnalyticsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberAnalyticsModel&&const DeepCollectionEquality().equals(other.leadershipTrend, leadershipTrend)&&const DeepCollectionEquality().equals(other.attendanceTrend, attendanceTrend)&&const DeepCollectionEquality().equals(other.taskTrend, taskTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leadershipTrend),const DeepCollectionEquality().hash(attendanceTrend),const DeepCollectionEquality().hash(taskTrend));

@override
String toString() {
  return 'MemberAnalyticsModel(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class $MemberAnalyticsModelCopyWith<$Res>  {
  factory $MemberAnalyticsModelCopyWith(MemberAnalyticsModel value, $Res Function(MemberAnalyticsModel) _then) = _$MemberAnalyticsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leadership_trend') List<int> leadershipTrend,@JsonKey(name: 'attendance_trend') List<int> attendanceTrend,@JsonKey(name: 'task_trend') List<int> taskTrend
});




}
/// @nodoc
class _$MemberAnalyticsModelCopyWithImpl<$Res>
    implements $MemberAnalyticsModelCopyWith<$Res> {
  _$MemberAnalyticsModelCopyWithImpl(this._self, this._then);

  final MemberAnalyticsModel _self;
  final $Res Function(MemberAnalyticsModel) _then;

/// Create a copy of MemberAnalyticsModel
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


/// Adds pattern-matching-related methods to [MemberAnalyticsModel].
extension MemberAnalyticsModelPatterns on MemberAnalyticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberAnalyticsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberAnalyticsModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberAnalyticsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberAnalyticsModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberAnalyticsModel() when $default != null:
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
case _MemberAnalyticsModel() when $default != null:
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
case _MemberAnalyticsModel():
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
case _MemberAnalyticsModel() when $default != null:
return $default(_that.leadershipTrend,_that.attendanceTrend,_that.taskTrend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberAnalyticsModel implements MemberAnalyticsModel {
  const _MemberAnalyticsModel({@JsonKey(name: 'leadership_trend') required final  List<int> leadershipTrend, @JsonKey(name: 'attendance_trend') required final  List<int> attendanceTrend, @JsonKey(name: 'task_trend') required final  List<int> taskTrend}): _leadershipTrend = leadershipTrend,_attendanceTrend = attendanceTrend,_taskTrend = taskTrend;
  factory _MemberAnalyticsModel.fromJson(Map<String, dynamic> json) => _$MemberAnalyticsModelFromJson(json);

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


/// Create a copy of MemberAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberAnalyticsModelCopyWith<_MemberAnalyticsModel> get copyWith => __$MemberAnalyticsModelCopyWithImpl<_MemberAnalyticsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberAnalyticsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberAnalyticsModel&&const DeepCollectionEquality().equals(other._leadershipTrend, _leadershipTrend)&&const DeepCollectionEquality().equals(other._attendanceTrend, _attendanceTrend)&&const DeepCollectionEquality().equals(other._taskTrend, _taskTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leadershipTrend),const DeepCollectionEquality().hash(_attendanceTrend),const DeepCollectionEquality().hash(_taskTrend));

@override
String toString() {
  return 'MemberAnalyticsModel(leadershipTrend: $leadershipTrend, attendanceTrend: $attendanceTrend, taskTrend: $taskTrend)';
}


}

/// @nodoc
abstract mixin class _$MemberAnalyticsModelCopyWith<$Res> implements $MemberAnalyticsModelCopyWith<$Res> {
  factory _$MemberAnalyticsModelCopyWith(_MemberAnalyticsModel value, $Res Function(_MemberAnalyticsModel) _then) = __$MemberAnalyticsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leadership_trend') List<int> leadershipTrend,@JsonKey(name: 'attendance_trend') List<int> attendanceTrend,@JsonKey(name: 'task_trend') List<int> taskTrend
});




}
/// @nodoc
class __$MemberAnalyticsModelCopyWithImpl<$Res>
    implements _$MemberAnalyticsModelCopyWith<$Res> {
  __$MemberAnalyticsModelCopyWithImpl(this._self, this._then);

  final _MemberAnalyticsModel _self;
  final $Res Function(_MemberAnalyticsModel) _then;

/// Create a copy of MemberAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadershipTrend = null,Object? attendanceTrend = null,Object? taskTrend = null,}) {
  return _then(_MemberAnalyticsModel(
leadershipTrend: null == leadershipTrend ? _self._leadershipTrend : leadershipTrend // ignore: cast_nullable_to_non_nullable
as List<int>,attendanceTrend: null == attendanceTrend ? _self._attendanceTrend : attendanceTrend // ignore: cast_nullable_to_non_nullable
as List<int>,taskTrend: null == taskTrend ? _self._taskTrend : taskTrend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
