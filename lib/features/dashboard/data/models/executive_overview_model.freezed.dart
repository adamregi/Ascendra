// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'executive_overview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExecutiveOverviewModel {

@JsonKey(name: 'health') OverviewHealth? get health;@JsonKey(name: 'growth') OverviewGrowth? get growth;@JsonKey(name: 'risk') OverviewRisk? get risk;@JsonKey(name: 'pipeline') OverviewPipeline? get pipeline;@JsonKey(name: 'pending_actions') OverviewActions? get pendingActions;@JsonKey(name: 'generated_at') DateTime? get generatedAt;// Fallback fields when data is empty
@JsonKey(name: 'team_health_score') double? get fallbackHealthScore;@JsonKey(name: 'team_size') int? get fallbackTeamSize;@JsonKey(name: 'message') String? get message;
/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutiveOverviewModelCopyWith<ExecutiveOverviewModel> get copyWith => _$ExecutiveOverviewModelCopyWithImpl<ExecutiveOverviewModel>(this as ExecutiveOverviewModel, _$identity);

  /// Serializes this ExecutiveOverviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutiveOverviewModel&&(identical(other.health, health) || other.health == health)&&(identical(other.growth, growth) || other.growth == growth)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.fallbackHealthScore, fallbackHealthScore) || other.fallbackHealthScore == fallbackHealthScore)&&(identical(other.fallbackTeamSize, fallbackTeamSize) || other.fallbackTeamSize == fallbackTeamSize)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,health,growth,risk,pipeline,pendingActions,generatedAt,fallbackHealthScore,fallbackTeamSize,message);

@override
String toString() {
  return 'ExecutiveOverviewModel(health: $health, growth: $growth, risk: $risk, pipeline: $pipeline, pendingActions: $pendingActions, generatedAt: $generatedAt, fallbackHealthScore: $fallbackHealthScore, fallbackTeamSize: $fallbackTeamSize, message: $message)';
}


}

/// @nodoc
abstract mixin class $ExecutiveOverviewModelCopyWith<$Res>  {
  factory $ExecutiveOverviewModelCopyWith(ExecutiveOverviewModel value, $Res Function(ExecutiveOverviewModel) _then) = _$ExecutiveOverviewModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'health') OverviewHealth? health,@JsonKey(name: 'growth') OverviewGrowth? growth,@JsonKey(name: 'risk') OverviewRisk? risk,@JsonKey(name: 'pipeline') OverviewPipeline? pipeline,@JsonKey(name: 'pending_actions') OverviewActions? pendingActions,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'team_health_score') double? fallbackHealthScore,@JsonKey(name: 'team_size') int? fallbackTeamSize,@JsonKey(name: 'message') String? message
});


$OverviewHealthCopyWith<$Res>? get health;$OverviewGrowthCopyWith<$Res>? get growth;$OverviewRiskCopyWith<$Res>? get risk;$OverviewPipelineCopyWith<$Res>? get pipeline;$OverviewActionsCopyWith<$Res>? get pendingActions;

}
/// @nodoc
class _$ExecutiveOverviewModelCopyWithImpl<$Res>
    implements $ExecutiveOverviewModelCopyWith<$Res> {
  _$ExecutiveOverviewModelCopyWithImpl(this._self, this._then);

  final ExecutiveOverviewModel _self;
  final $Res Function(ExecutiveOverviewModel) _then;

/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? health = freezed,Object? growth = freezed,Object? risk = freezed,Object? pipeline = freezed,Object? pendingActions = freezed,Object? generatedAt = freezed,Object? fallbackHealthScore = freezed,Object? fallbackTeamSize = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
health: freezed == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as OverviewHealth?,growth: freezed == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as OverviewGrowth?,risk: freezed == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as OverviewRisk?,pipeline: freezed == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as OverviewPipeline?,pendingActions: freezed == pendingActions ? _self.pendingActions : pendingActions // ignore: cast_nullable_to_non_nullable
as OverviewActions?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fallbackHealthScore: freezed == fallbackHealthScore ? _self.fallbackHealthScore : fallbackHealthScore // ignore: cast_nullable_to_non_nullable
as double?,fallbackTeamSize: freezed == fallbackTeamSize ? _self.fallbackTeamSize : fallbackTeamSize // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewHealthCopyWith<$Res>? get health {
    if (_self.health == null) {
    return null;
  }

  return $OverviewHealthCopyWith<$Res>(_self.health!, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewGrowthCopyWith<$Res>? get growth {
    if (_self.growth == null) {
    return null;
  }

  return $OverviewGrowthCopyWith<$Res>(_self.growth!, (value) {
    return _then(_self.copyWith(growth: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewRiskCopyWith<$Res>? get risk {
    if (_self.risk == null) {
    return null;
  }

  return $OverviewRiskCopyWith<$Res>(_self.risk!, (value) {
    return _then(_self.copyWith(risk: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewPipelineCopyWith<$Res>? get pipeline {
    if (_self.pipeline == null) {
    return null;
  }

  return $OverviewPipelineCopyWith<$Res>(_self.pipeline!, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewActionsCopyWith<$Res>? get pendingActions {
    if (_self.pendingActions == null) {
    return null;
  }

  return $OverviewActionsCopyWith<$Res>(_self.pendingActions!, (value) {
    return _then(_self.copyWith(pendingActions: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExecutiveOverviewModel].
extension ExecutiveOverviewModelPatterns on ExecutiveOverviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutiveOverviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutiveOverviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutiveOverviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ExecutiveOverviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutiveOverviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutiveOverviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'health')  OverviewHealth? health, @JsonKey(name: 'growth')  OverviewGrowth? growth, @JsonKey(name: 'risk')  OverviewRisk? risk, @JsonKey(name: 'pipeline')  OverviewPipeline? pipeline, @JsonKey(name: 'pending_actions')  OverviewActions? pendingActions, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'team_health_score')  double? fallbackHealthScore, @JsonKey(name: 'team_size')  int? fallbackTeamSize, @JsonKey(name: 'message')  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutiveOverviewModel() when $default != null:
return $default(_that.health,_that.growth,_that.risk,_that.pipeline,_that.pendingActions,_that.generatedAt,_that.fallbackHealthScore,_that.fallbackTeamSize,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'health')  OverviewHealth? health, @JsonKey(name: 'growth')  OverviewGrowth? growth, @JsonKey(name: 'risk')  OverviewRisk? risk, @JsonKey(name: 'pipeline')  OverviewPipeline? pipeline, @JsonKey(name: 'pending_actions')  OverviewActions? pendingActions, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'team_health_score')  double? fallbackHealthScore, @JsonKey(name: 'team_size')  int? fallbackTeamSize, @JsonKey(name: 'message')  String? message)  $default,) {final _that = this;
switch (_that) {
case _ExecutiveOverviewModel():
return $default(_that.health,_that.growth,_that.risk,_that.pipeline,_that.pendingActions,_that.generatedAt,_that.fallbackHealthScore,_that.fallbackTeamSize,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'health')  OverviewHealth? health, @JsonKey(name: 'growth')  OverviewGrowth? growth, @JsonKey(name: 'risk')  OverviewRisk? risk, @JsonKey(name: 'pipeline')  OverviewPipeline? pipeline, @JsonKey(name: 'pending_actions')  OverviewActions? pendingActions, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'team_health_score')  double? fallbackHealthScore, @JsonKey(name: 'team_size')  int? fallbackTeamSize, @JsonKey(name: 'message')  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ExecutiveOverviewModel() when $default != null:
return $default(_that.health,_that.growth,_that.risk,_that.pipeline,_that.pendingActions,_that.generatedAt,_that.fallbackHealthScore,_that.fallbackTeamSize,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecutiveOverviewModel implements ExecutiveOverviewModel {
  const _ExecutiveOverviewModel({@JsonKey(name: 'health') this.health, @JsonKey(name: 'growth') this.growth, @JsonKey(name: 'risk') this.risk, @JsonKey(name: 'pipeline') this.pipeline, @JsonKey(name: 'pending_actions') this.pendingActions, @JsonKey(name: 'generated_at') this.generatedAt, @JsonKey(name: 'team_health_score') this.fallbackHealthScore, @JsonKey(name: 'team_size') this.fallbackTeamSize, @JsonKey(name: 'message') this.message});
  factory _ExecutiveOverviewModel.fromJson(Map<String, dynamic> json) => _$ExecutiveOverviewModelFromJson(json);

@override@JsonKey(name: 'health') final  OverviewHealth? health;
@override@JsonKey(name: 'growth') final  OverviewGrowth? growth;
@override@JsonKey(name: 'risk') final  OverviewRisk? risk;
@override@JsonKey(name: 'pipeline') final  OverviewPipeline? pipeline;
@override@JsonKey(name: 'pending_actions') final  OverviewActions? pendingActions;
@override@JsonKey(name: 'generated_at') final  DateTime? generatedAt;
// Fallback fields when data is empty
@override@JsonKey(name: 'team_health_score') final  double? fallbackHealthScore;
@override@JsonKey(name: 'team_size') final  int? fallbackTeamSize;
@override@JsonKey(name: 'message') final  String? message;

/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutiveOverviewModelCopyWith<_ExecutiveOverviewModel> get copyWith => __$ExecutiveOverviewModelCopyWithImpl<_ExecutiveOverviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecutiveOverviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutiveOverviewModel&&(identical(other.health, health) || other.health == health)&&(identical(other.growth, growth) || other.growth == growth)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.fallbackHealthScore, fallbackHealthScore) || other.fallbackHealthScore == fallbackHealthScore)&&(identical(other.fallbackTeamSize, fallbackTeamSize) || other.fallbackTeamSize == fallbackTeamSize)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,health,growth,risk,pipeline,pendingActions,generatedAt,fallbackHealthScore,fallbackTeamSize,message);

@override
String toString() {
  return 'ExecutiveOverviewModel(health: $health, growth: $growth, risk: $risk, pipeline: $pipeline, pendingActions: $pendingActions, generatedAt: $generatedAt, fallbackHealthScore: $fallbackHealthScore, fallbackTeamSize: $fallbackTeamSize, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ExecutiveOverviewModelCopyWith<$Res> implements $ExecutiveOverviewModelCopyWith<$Res> {
  factory _$ExecutiveOverviewModelCopyWith(_ExecutiveOverviewModel value, $Res Function(_ExecutiveOverviewModel) _then) = __$ExecutiveOverviewModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'health') OverviewHealth? health,@JsonKey(name: 'growth') OverviewGrowth? growth,@JsonKey(name: 'risk') OverviewRisk? risk,@JsonKey(name: 'pipeline') OverviewPipeline? pipeline,@JsonKey(name: 'pending_actions') OverviewActions? pendingActions,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'team_health_score') double? fallbackHealthScore,@JsonKey(name: 'team_size') int? fallbackTeamSize,@JsonKey(name: 'message') String? message
});


@override $OverviewHealthCopyWith<$Res>? get health;@override $OverviewGrowthCopyWith<$Res>? get growth;@override $OverviewRiskCopyWith<$Res>? get risk;@override $OverviewPipelineCopyWith<$Res>? get pipeline;@override $OverviewActionsCopyWith<$Res>? get pendingActions;

}
/// @nodoc
class __$ExecutiveOverviewModelCopyWithImpl<$Res>
    implements _$ExecutiveOverviewModelCopyWith<$Res> {
  __$ExecutiveOverviewModelCopyWithImpl(this._self, this._then);

  final _ExecutiveOverviewModel _self;
  final $Res Function(_ExecutiveOverviewModel) _then;

/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? health = freezed,Object? growth = freezed,Object? risk = freezed,Object? pipeline = freezed,Object? pendingActions = freezed,Object? generatedAt = freezed,Object? fallbackHealthScore = freezed,Object? fallbackTeamSize = freezed,Object? message = freezed,}) {
  return _then(_ExecutiveOverviewModel(
health: freezed == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as OverviewHealth?,growth: freezed == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as OverviewGrowth?,risk: freezed == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as OverviewRisk?,pipeline: freezed == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as OverviewPipeline?,pendingActions: freezed == pendingActions ? _self.pendingActions : pendingActions // ignore: cast_nullable_to_non_nullable
as OverviewActions?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fallbackHealthScore: freezed == fallbackHealthScore ? _self.fallbackHealthScore : fallbackHealthScore // ignore: cast_nullable_to_non_nullable
as double?,fallbackTeamSize: freezed == fallbackTeamSize ? _self.fallbackTeamSize : fallbackTeamSize // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewHealthCopyWith<$Res>? get health {
    if (_self.health == null) {
    return null;
  }

  return $OverviewHealthCopyWith<$Res>(_self.health!, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewGrowthCopyWith<$Res>? get growth {
    if (_self.growth == null) {
    return null;
  }

  return $OverviewGrowthCopyWith<$Res>(_self.growth!, (value) {
    return _then(_self.copyWith(growth: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewRiskCopyWith<$Res>? get risk {
    if (_self.risk == null) {
    return null;
  }

  return $OverviewRiskCopyWith<$Res>(_self.risk!, (value) {
    return _then(_self.copyWith(risk: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewPipelineCopyWith<$Res>? get pipeline {
    if (_self.pipeline == null) {
    return null;
  }

  return $OverviewPipelineCopyWith<$Res>(_self.pipeline!, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}/// Create a copy of ExecutiveOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OverviewActionsCopyWith<$Res>? get pendingActions {
    if (_self.pendingActions == null) {
    return null;
  }

  return $OverviewActionsCopyWith<$Res>(_self.pendingActions!, (value) {
    return _then(_self.copyWith(pendingActions: value));
  });
}
}


/// @nodoc
mixin _$OverviewHealth {

@JsonKey(name: 'team_health_score') double get teamHealthScore;@JsonKey(name: 'team_size') int get teamSize;@JsonKey(name: 'active_members') int get activeMembers;@JsonKey(name: 'attendance_rate') double get attendanceRate;@JsonKey(name: 'completion_rate') double get completionRate;
/// Create a copy of OverviewHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewHealthCopyWith<OverviewHealth> get copyWith => _$OverviewHealthCopyWithImpl<OverviewHealth>(this as OverviewHealth, _$identity);

  /// Serializes this OverviewHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewHealth&&(identical(other.teamHealthScore, teamHealthScore) || other.teamHealthScore == teamHealthScore)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&(identical(other.activeMembers, activeMembers) || other.activeMembers == activeMembers)&&(identical(other.attendanceRate, attendanceRate) || other.attendanceRate == attendanceRate)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamHealthScore,teamSize,activeMembers,attendanceRate,completionRate);

@override
String toString() {
  return 'OverviewHealth(teamHealthScore: $teamHealthScore, teamSize: $teamSize, activeMembers: $activeMembers, attendanceRate: $attendanceRate, completionRate: $completionRate)';
}


}

/// @nodoc
abstract mixin class $OverviewHealthCopyWith<$Res>  {
  factory $OverviewHealthCopyWith(OverviewHealth value, $Res Function(OverviewHealth) _then) = _$OverviewHealthCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'team_health_score') double teamHealthScore,@JsonKey(name: 'team_size') int teamSize,@JsonKey(name: 'active_members') int activeMembers,@JsonKey(name: 'attendance_rate') double attendanceRate,@JsonKey(name: 'completion_rate') double completionRate
});




}
/// @nodoc
class _$OverviewHealthCopyWithImpl<$Res>
    implements $OverviewHealthCopyWith<$Res> {
  _$OverviewHealthCopyWithImpl(this._self, this._then);

  final OverviewHealth _self;
  final $Res Function(OverviewHealth) _then;

/// Create a copy of OverviewHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamHealthScore = null,Object? teamSize = null,Object? activeMembers = null,Object? attendanceRate = null,Object? completionRate = null,}) {
  return _then(_self.copyWith(
teamHealthScore: null == teamHealthScore ? _self.teamHealthScore : teamHealthScore // ignore: cast_nullable_to_non_nullable
as double,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as int,activeMembers: null == activeMembers ? _self.activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as int,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewHealth].
extension OverviewHealthPatterns on OverviewHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewHealth value)  $default,){
final _that = this;
switch (_that) {
case _OverviewHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewHealth value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'team_health_score')  double teamHealthScore, @JsonKey(name: 'team_size')  int teamSize, @JsonKey(name: 'active_members')  int activeMembers, @JsonKey(name: 'attendance_rate')  double attendanceRate, @JsonKey(name: 'completion_rate')  double completionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewHealth() when $default != null:
return $default(_that.teamHealthScore,_that.teamSize,_that.activeMembers,_that.attendanceRate,_that.completionRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'team_health_score')  double teamHealthScore, @JsonKey(name: 'team_size')  int teamSize, @JsonKey(name: 'active_members')  int activeMembers, @JsonKey(name: 'attendance_rate')  double attendanceRate, @JsonKey(name: 'completion_rate')  double completionRate)  $default,) {final _that = this;
switch (_that) {
case _OverviewHealth():
return $default(_that.teamHealthScore,_that.teamSize,_that.activeMembers,_that.attendanceRate,_that.completionRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'team_health_score')  double teamHealthScore, @JsonKey(name: 'team_size')  int teamSize, @JsonKey(name: 'active_members')  int activeMembers, @JsonKey(name: 'attendance_rate')  double attendanceRate, @JsonKey(name: 'completion_rate')  double completionRate)?  $default,) {final _that = this;
switch (_that) {
case _OverviewHealth() when $default != null:
return $default(_that.teamHealthScore,_that.teamSize,_that.activeMembers,_that.attendanceRate,_that.completionRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverviewHealth implements OverviewHealth {
  const _OverviewHealth({@JsonKey(name: 'team_health_score') required this.teamHealthScore, @JsonKey(name: 'team_size') required this.teamSize, @JsonKey(name: 'active_members') required this.activeMembers, @JsonKey(name: 'attendance_rate') required this.attendanceRate, @JsonKey(name: 'completion_rate') required this.completionRate});
  factory _OverviewHealth.fromJson(Map<String, dynamic> json) => _$OverviewHealthFromJson(json);

@override@JsonKey(name: 'team_health_score') final  double teamHealthScore;
@override@JsonKey(name: 'team_size') final  int teamSize;
@override@JsonKey(name: 'active_members') final  int activeMembers;
@override@JsonKey(name: 'attendance_rate') final  double attendanceRate;
@override@JsonKey(name: 'completion_rate') final  double completionRate;

/// Create a copy of OverviewHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewHealthCopyWith<_OverviewHealth> get copyWith => __$OverviewHealthCopyWithImpl<_OverviewHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverviewHealthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewHealth&&(identical(other.teamHealthScore, teamHealthScore) || other.teamHealthScore == teamHealthScore)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&(identical(other.activeMembers, activeMembers) || other.activeMembers == activeMembers)&&(identical(other.attendanceRate, attendanceRate) || other.attendanceRate == attendanceRate)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamHealthScore,teamSize,activeMembers,attendanceRate,completionRate);

@override
String toString() {
  return 'OverviewHealth(teamHealthScore: $teamHealthScore, teamSize: $teamSize, activeMembers: $activeMembers, attendanceRate: $attendanceRate, completionRate: $completionRate)';
}


}

/// @nodoc
abstract mixin class _$OverviewHealthCopyWith<$Res> implements $OverviewHealthCopyWith<$Res> {
  factory _$OverviewHealthCopyWith(_OverviewHealth value, $Res Function(_OverviewHealth) _then) = __$OverviewHealthCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'team_health_score') double teamHealthScore,@JsonKey(name: 'team_size') int teamSize,@JsonKey(name: 'active_members') int activeMembers,@JsonKey(name: 'attendance_rate') double attendanceRate,@JsonKey(name: 'completion_rate') double completionRate
});




}
/// @nodoc
class __$OverviewHealthCopyWithImpl<$Res>
    implements _$OverviewHealthCopyWith<$Res> {
  __$OverviewHealthCopyWithImpl(this._self, this._then);

  final _OverviewHealth _self;
  final $Res Function(_OverviewHealth) _then;

/// Create a copy of OverviewHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamHealthScore = null,Object? teamSize = null,Object? activeMembers = null,Object? attendanceRate = null,Object? completionRate = null,}) {
  return _then(_OverviewHealth(
teamHealthScore: null == teamHealthScore ? _self.teamHealthScore : teamHealthScore // ignore: cast_nullable_to_non_nullable
as double,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as int,activeMembers: null == activeMembers ? _self.activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as int,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OverviewGrowth {

@JsonKey(name: 'team_growth_score') double get teamGrowthScore;@JsonKey(name: 'task_growth_score') double get taskGrowthScore;
/// Create a copy of OverviewGrowth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewGrowthCopyWith<OverviewGrowth> get copyWith => _$OverviewGrowthCopyWithImpl<OverviewGrowth>(this as OverviewGrowth, _$identity);

  /// Serializes this OverviewGrowth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewGrowth&&(identical(other.teamGrowthScore, teamGrowthScore) || other.teamGrowthScore == teamGrowthScore)&&(identical(other.taskGrowthScore, taskGrowthScore) || other.taskGrowthScore == taskGrowthScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamGrowthScore,taskGrowthScore);

@override
String toString() {
  return 'OverviewGrowth(teamGrowthScore: $teamGrowthScore, taskGrowthScore: $taskGrowthScore)';
}


}

/// @nodoc
abstract mixin class $OverviewGrowthCopyWith<$Res>  {
  factory $OverviewGrowthCopyWith(OverviewGrowth value, $Res Function(OverviewGrowth) _then) = _$OverviewGrowthCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'team_growth_score') double teamGrowthScore,@JsonKey(name: 'task_growth_score') double taskGrowthScore
});




}
/// @nodoc
class _$OverviewGrowthCopyWithImpl<$Res>
    implements $OverviewGrowthCopyWith<$Res> {
  _$OverviewGrowthCopyWithImpl(this._self, this._then);

  final OverviewGrowth _self;
  final $Res Function(OverviewGrowth) _then;

/// Create a copy of OverviewGrowth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamGrowthScore = null,Object? taskGrowthScore = null,}) {
  return _then(_self.copyWith(
teamGrowthScore: null == teamGrowthScore ? _self.teamGrowthScore : teamGrowthScore // ignore: cast_nullable_to_non_nullable
as double,taskGrowthScore: null == taskGrowthScore ? _self.taskGrowthScore : taskGrowthScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewGrowth].
extension OverviewGrowthPatterns on OverviewGrowth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewGrowth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewGrowth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewGrowth value)  $default,){
final _that = this;
switch (_that) {
case _OverviewGrowth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewGrowth value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewGrowth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'team_growth_score')  double teamGrowthScore, @JsonKey(name: 'task_growth_score')  double taskGrowthScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewGrowth() when $default != null:
return $default(_that.teamGrowthScore,_that.taskGrowthScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'team_growth_score')  double teamGrowthScore, @JsonKey(name: 'task_growth_score')  double taskGrowthScore)  $default,) {final _that = this;
switch (_that) {
case _OverviewGrowth():
return $default(_that.teamGrowthScore,_that.taskGrowthScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'team_growth_score')  double teamGrowthScore, @JsonKey(name: 'task_growth_score')  double taskGrowthScore)?  $default,) {final _that = this;
switch (_that) {
case _OverviewGrowth() when $default != null:
return $default(_that.teamGrowthScore,_that.taskGrowthScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverviewGrowth implements OverviewGrowth {
  const _OverviewGrowth({@JsonKey(name: 'team_growth_score') required this.teamGrowthScore, @JsonKey(name: 'task_growth_score') required this.taskGrowthScore});
  factory _OverviewGrowth.fromJson(Map<String, dynamic> json) => _$OverviewGrowthFromJson(json);

@override@JsonKey(name: 'team_growth_score') final  double teamGrowthScore;
@override@JsonKey(name: 'task_growth_score') final  double taskGrowthScore;

/// Create a copy of OverviewGrowth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewGrowthCopyWith<_OverviewGrowth> get copyWith => __$OverviewGrowthCopyWithImpl<_OverviewGrowth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverviewGrowthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewGrowth&&(identical(other.teamGrowthScore, teamGrowthScore) || other.teamGrowthScore == teamGrowthScore)&&(identical(other.taskGrowthScore, taskGrowthScore) || other.taskGrowthScore == taskGrowthScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamGrowthScore,taskGrowthScore);

@override
String toString() {
  return 'OverviewGrowth(teamGrowthScore: $teamGrowthScore, taskGrowthScore: $taskGrowthScore)';
}


}

/// @nodoc
abstract mixin class _$OverviewGrowthCopyWith<$Res> implements $OverviewGrowthCopyWith<$Res> {
  factory _$OverviewGrowthCopyWith(_OverviewGrowth value, $Res Function(_OverviewGrowth) _then) = __$OverviewGrowthCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'team_growth_score') double teamGrowthScore,@JsonKey(name: 'task_growth_score') double taskGrowthScore
});




}
/// @nodoc
class __$OverviewGrowthCopyWithImpl<$Res>
    implements _$OverviewGrowthCopyWith<$Res> {
  __$OverviewGrowthCopyWithImpl(this._self, this._then);

  final _OverviewGrowth _self;
  final $Res Function(_OverviewGrowth) _then;

/// Create a copy of OverviewGrowth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamGrowthScore = null,Object? taskGrowthScore = null,}) {
  return _then(_OverviewGrowth(
teamGrowthScore: null == teamGrowthScore ? _self.teamGrowthScore : teamGrowthScore // ignore: cast_nullable_to_non_nullable
as double,taskGrowthScore: null == taskGrowthScore ? _self.taskGrowthScore : taskGrowthScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OverviewRisk {

 int get low; int get medium; int get high; int get critical;@JsonKey(name: 'risk_percentage') double get riskPercentage;
/// Create a copy of OverviewRisk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewRiskCopyWith<OverviewRisk> get copyWith => _$OverviewRiskCopyWithImpl<OverviewRisk>(this as OverviewRisk, _$identity);

  /// Serializes this OverviewRisk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewRisk&&(identical(other.low, low) || other.low == low)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.high, high) || other.high == high)&&(identical(other.critical, critical) || other.critical == critical)&&(identical(other.riskPercentage, riskPercentage) || other.riskPercentage == riskPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,low,medium,high,critical,riskPercentage);

@override
String toString() {
  return 'OverviewRisk(low: $low, medium: $medium, high: $high, critical: $critical, riskPercentage: $riskPercentage)';
}


}

/// @nodoc
abstract mixin class $OverviewRiskCopyWith<$Res>  {
  factory $OverviewRiskCopyWith(OverviewRisk value, $Res Function(OverviewRisk) _then) = _$OverviewRiskCopyWithImpl;
@useResult
$Res call({
 int low, int medium, int high, int critical,@JsonKey(name: 'risk_percentage') double riskPercentage
});




}
/// @nodoc
class _$OverviewRiskCopyWithImpl<$Res>
    implements $OverviewRiskCopyWith<$Res> {
  _$OverviewRiskCopyWithImpl(this._self, this._then);

  final OverviewRisk _self;
  final $Res Function(OverviewRisk) _then;

/// Create a copy of OverviewRisk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? low = null,Object? medium = null,Object? high = null,Object? critical = null,Object? riskPercentage = null,}) {
  return _then(_self.copyWith(
low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as int,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as int,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as int,critical: null == critical ? _self.critical : critical // ignore: cast_nullable_to_non_nullable
as int,riskPercentage: null == riskPercentage ? _self.riskPercentage : riskPercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewRisk].
extension OverviewRiskPatterns on OverviewRisk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewRisk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewRisk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewRisk value)  $default,){
final _that = this;
switch (_that) {
case _OverviewRisk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewRisk value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewRisk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int low,  int medium,  int high,  int critical, @JsonKey(name: 'risk_percentage')  double riskPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewRisk() when $default != null:
return $default(_that.low,_that.medium,_that.high,_that.critical,_that.riskPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int low,  int medium,  int high,  int critical, @JsonKey(name: 'risk_percentage')  double riskPercentage)  $default,) {final _that = this;
switch (_that) {
case _OverviewRisk():
return $default(_that.low,_that.medium,_that.high,_that.critical,_that.riskPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int low,  int medium,  int high,  int critical, @JsonKey(name: 'risk_percentage')  double riskPercentage)?  $default,) {final _that = this;
switch (_that) {
case _OverviewRisk() when $default != null:
return $default(_that.low,_that.medium,_that.high,_that.critical,_that.riskPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverviewRisk implements OverviewRisk {
  const _OverviewRisk({required this.low, required this.medium, required this.high, required this.critical, @JsonKey(name: 'risk_percentage') required this.riskPercentage});
  factory _OverviewRisk.fromJson(Map<String, dynamic> json) => _$OverviewRiskFromJson(json);

@override final  int low;
@override final  int medium;
@override final  int high;
@override final  int critical;
@override@JsonKey(name: 'risk_percentage') final  double riskPercentage;

/// Create a copy of OverviewRisk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewRiskCopyWith<_OverviewRisk> get copyWith => __$OverviewRiskCopyWithImpl<_OverviewRisk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverviewRiskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewRisk&&(identical(other.low, low) || other.low == low)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.high, high) || other.high == high)&&(identical(other.critical, critical) || other.critical == critical)&&(identical(other.riskPercentage, riskPercentage) || other.riskPercentage == riskPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,low,medium,high,critical,riskPercentage);

@override
String toString() {
  return 'OverviewRisk(low: $low, medium: $medium, high: $high, critical: $critical, riskPercentage: $riskPercentage)';
}


}

/// @nodoc
abstract mixin class _$OverviewRiskCopyWith<$Res> implements $OverviewRiskCopyWith<$Res> {
  factory _$OverviewRiskCopyWith(_OverviewRisk value, $Res Function(_OverviewRisk) _then) = __$OverviewRiskCopyWithImpl;
@override @useResult
$Res call({
 int low, int medium, int high, int critical,@JsonKey(name: 'risk_percentage') double riskPercentage
});




}
/// @nodoc
class __$OverviewRiskCopyWithImpl<$Res>
    implements _$OverviewRiskCopyWith<$Res> {
  __$OverviewRiskCopyWithImpl(this._self, this._then);

  final _OverviewRisk _self;
  final $Res Function(_OverviewRisk) _then;

/// Create a copy of OverviewRisk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? low = null,Object? medium = null,Object? high = null,Object? critical = null,Object? riskPercentage = null,}) {
  return _then(_OverviewRisk(
low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as int,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as int,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as int,critical: null == critical ? _self.critical : critical // ignore: cast_nullable_to_non_nullable
as int,riskPercentage: null == riskPercentage ? _self.riskPercentage : riskPercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OverviewPipeline {

@JsonKey(name: 'future_leaders') int get futureLeaders;@JsonKey(name: 'emerging_leaders') int get emergingLeaders; int get developing;@JsonKey(name: 'needs_development') int get needsDevelopment;@JsonKey(name: 'top_performers') int get topPerformers;
/// Create a copy of OverviewPipeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewPipelineCopyWith<OverviewPipeline> get copyWith => _$OverviewPipelineCopyWithImpl<OverviewPipeline>(this as OverviewPipeline, _$identity);

  /// Serializes this OverviewPipeline to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewPipeline&&(identical(other.futureLeaders, futureLeaders) || other.futureLeaders == futureLeaders)&&(identical(other.emergingLeaders, emergingLeaders) || other.emergingLeaders == emergingLeaders)&&(identical(other.developing, developing) || other.developing == developing)&&(identical(other.needsDevelopment, needsDevelopment) || other.needsDevelopment == needsDevelopment)&&(identical(other.topPerformers, topPerformers) || other.topPerformers == topPerformers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,futureLeaders,emergingLeaders,developing,needsDevelopment,topPerformers);

@override
String toString() {
  return 'OverviewPipeline(futureLeaders: $futureLeaders, emergingLeaders: $emergingLeaders, developing: $developing, needsDevelopment: $needsDevelopment, topPerformers: $topPerformers)';
}


}

/// @nodoc
abstract mixin class $OverviewPipelineCopyWith<$Res>  {
  factory $OverviewPipelineCopyWith(OverviewPipeline value, $Res Function(OverviewPipeline) _then) = _$OverviewPipelineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'future_leaders') int futureLeaders,@JsonKey(name: 'emerging_leaders') int emergingLeaders, int developing,@JsonKey(name: 'needs_development') int needsDevelopment,@JsonKey(name: 'top_performers') int topPerformers
});




}
/// @nodoc
class _$OverviewPipelineCopyWithImpl<$Res>
    implements $OverviewPipelineCopyWith<$Res> {
  _$OverviewPipelineCopyWithImpl(this._self, this._then);

  final OverviewPipeline _self;
  final $Res Function(OverviewPipeline) _then;

/// Create a copy of OverviewPipeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? futureLeaders = null,Object? emergingLeaders = null,Object? developing = null,Object? needsDevelopment = null,Object? topPerformers = null,}) {
  return _then(_self.copyWith(
futureLeaders: null == futureLeaders ? _self.futureLeaders : futureLeaders // ignore: cast_nullable_to_non_nullable
as int,emergingLeaders: null == emergingLeaders ? _self.emergingLeaders : emergingLeaders // ignore: cast_nullable_to_non_nullable
as int,developing: null == developing ? _self.developing : developing // ignore: cast_nullable_to_non_nullable
as int,needsDevelopment: null == needsDevelopment ? _self.needsDevelopment : needsDevelopment // ignore: cast_nullable_to_non_nullable
as int,topPerformers: null == topPerformers ? _self.topPerformers : topPerformers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewPipeline].
extension OverviewPipelinePatterns on OverviewPipeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewPipeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewPipeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewPipeline value)  $default,){
final _that = this;
switch (_that) {
case _OverviewPipeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewPipeline value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewPipeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'future_leaders')  int futureLeaders, @JsonKey(name: 'emerging_leaders')  int emergingLeaders,  int developing, @JsonKey(name: 'needs_development')  int needsDevelopment, @JsonKey(name: 'top_performers')  int topPerformers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewPipeline() when $default != null:
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment,_that.topPerformers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'future_leaders')  int futureLeaders, @JsonKey(name: 'emerging_leaders')  int emergingLeaders,  int developing, @JsonKey(name: 'needs_development')  int needsDevelopment, @JsonKey(name: 'top_performers')  int topPerformers)  $default,) {final _that = this;
switch (_that) {
case _OverviewPipeline():
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment,_that.topPerformers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'future_leaders')  int futureLeaders, @JsonKey(name: 'emerging_leaders')  int emergingLeaders,  int developing, @JsonKey(name: 'needs_development')  int needsDevelopment, @JsonKey(name: 'top_performers')  int topPerformers)?  $default,) {final _that = this;
switch (_that) {
case _OverviewPipeline() when $default != null:
return $default(_that.futureLeaders,_that.emergingLeaders,_that.developing,_that.needsDevelopment,_that.topPerformers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverviewPipeline implements OverviewPipeline {
  const _OverviewPipeline({@JsonKey(name: 'future_leaders') required this.futureLeaders, @JsonKey(name: 'emerging_leaders') required this.emergingLeaders, required this.developing, @JsonKey(name: 'needs_development') required this.needsDevelopment, @JsonKey(name: 'top_performers') required this.topPerformers});
  factory _OverviewPipeline.fromJson(Map<String, dynamic> json) => _$OverviewPipelineFromJson(json);

@override@JsonKey(name: 'future_leaders') final  int futureLeaders;
@override@JsonKey(name: 'emerging_leaders') final  int emergingLeaders;
@override final  int developing;
@override@JsonKey(name: 'needs_development') final  int needsDevelopment;
@override@JsonKey(name: 'top_performers') final  int topPerformers;

/// Create a copy of OverviewPipeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewPipelineCopyWith<_OverviewPipeline> get copyWith => __$OverviewPipelineCopyWithImpl<_OverviewPipeline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverviewPipelineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewPipeline&&(identical(other.futureLeaders, futureLeaders) || other.futureLeaders == futureLeaders)&&(identical(other.emergingLeaders, emergingLeaders) || other.emergingLeaders == emergingLeaders)&&(identical(other.developing, developing) || other.developing == developing)&&(identical(other.needsDevelopment, needsDevelopment) || other.needsDevelopment == needsDevelopment)&&(identical(other.topPerformers, topPerformers) || other.topPerformers == topPerformers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,futureLeaders,emergingLeaders,developing,needsDevelopment,topPerformers);

@override
String toString() {
  return 'OverviewPipeline(futureLeaders: $futureLeaders, emergingLeaders: $emergingLeaders, developing: $developing, needsDevelopment: $needsDevelopment, topPerformers: $topPerformers)';
}


}

/// @nodoc
abstract mixin class _$OverviewPipelineCopyWith<$Res> implements $OverviewPipelineCopyWith<$Res> {
  factory _$OverviewPipelineCopyWith(_OverviewPipeline value, $Res Function(_OverviewPipeline) _then) = __$OverviewPipelineCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'future_leaders') int futureLeaders,@JsonKey(name: 'emerging_leaders') int emergingLeaders, int developing,@JsonKey(name: 'needs_development') int needsDevelopment,@JsonKey(name: 'top_performers') int topPerformers
});




}
/// @nodoc
class __$OverviewPipelineCopyWithImpl<$Res>
    implements _$OverviewPipelineCopyWith<$Res> {
  __$OverviewPipelineCopyWithImpl(this._self, this._then);

  final _OverviewPipeline _self;
  final $Res Function(_OverviewPipeline) _then;

/// Create a copy of OverviewPipeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? futureLeaders = null,Object? emergingLeaders = null,Object? developing = null,Object? needsDevelopment = null,Object? topPerformers = null,}) {
  return _then(_OverviewPipeline(
futureLeaders: null == futureLeaders ? _self.futureLeaders : futureLeaders // ignore: cast_nullable_to_non_nullable
as int,emergingLeaders: null == emergingLeaders ? _self.emergingLeaders : emergingLeaders // ignore: cast_nullable_to_non_nullable
as int,developing: null == developing ? _self.developing : developing // ignore: cast_nullable_to_non_nullable
as int,needsDevelopment: null == needsDevelopment ? _self.needsDevelopment : needsDevelopment // ignore: cast_nullable_to_non_nullable
as int,topPerformers: null == topPerformers ? _self.topPerformers : topPerformers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$OverviewActions {

 int get promotions; int get recognitions; int get mentorships; int get trainings; int get coaching; int get total;
/// Create a copy of OverviewActions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewActionsCopyWith<OverviewActions> get copyWith => _$OverviewActionsCopyWithImpl<OverviewActions>(this as OverviewActions, _$identity);

  /// Serializes this OverviewActions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewActions&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.recognitions, recognitions) || other.recognitions == recognitions)&&(identical(other.mentorships, mentorships) || other.mentorships == mentorships)&&(identical(other.trainings, trainings) || other.trainings == trainings)&&(identical(other.coaching, coaching) || other.coaching == coaching)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,promotions,recognitions,mentorships,trainings,coaching,total);

@override
String toString() {
  return 'OverviewActions(promotions: $promotions, recognitions: $recognitions, mentorships: $mentorships, trainings: $trainings, coaching: $coaching, total: $total)';
}


}

/// @nodoc
abstract mixin class $OverviewActionsCopyWith<$Res>  {
  factory $OverviewActionsCopyWith(OverviewActions value, $Res Function(OverviewActions) _then) = _$OverviewActionsCopyWithImpl;
@useResult
$Res call({
 int promotions, int recognitions, int mentorships, int trainings, int coaching, int total
});




}
/// @nodoc
class _$OverviewActionsCopyWithImpl<$Res>
    implements $OverviewActionsCopyWith<$Res> {
  _$OverviewActionsCopyWithImpl(this._self, this._then);

  final OverviewActions _self;
  final $Res Function(OverviewActions) _then;

/// Create a copy of OverviewActions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? promotions = null,Object? recognitions = null,Object? mentorships = null,Object? trainings = null,Object? coaching = null,Object? total = null,}) {
  return _then(_self.copyWith(
promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as int,recognitions: null == recognitions ? _self.recognitions : recognitions // ignore: cast_nullable_to_non_nullable
as int,mentorships: null == mentorships ? _self.mentorships : mentorships // ignore: cast_nullable_to_non_nullable
as int,trainings: null == trainings ? _self.trainings : trainings // ignore: cast_nullable_to_non_nullable
as int,coaching: null == coaching ? _self.coaching : coaching // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewActions].
extension OverviewActionsPatterns on OverviewActions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewActions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewActions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewActions value)  $default,){
final _that = this;
switch (_that) {
case _OverviewActions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewActions value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewActions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int promotions,  int recognitions,  int mentorships,  int trainings,  int coaching,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewActions() when $default != null:
return $default(_that.promotions,_that.recognitions,_that.mentorships,_that.trainings,_that.coaching,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int promotions,  int recognitions,  int mentorships,  int trainings,  int coaching,  int total)  $default,) {final _that = this;
switch (_that) {
case _OverviewActions():
return $default(_that.promotions,_that.recognitions,_that.mentorships,_that.trainings,_that.coaching,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int promotions,  int recognitions,  int mentorships,  int trainings,  int coaching,  int total)?  $default,) {final _that = this;
switch (_that) {
case _OverviewActions() when $default != null:
return $default(_that.promotions,_that.recognitions,_that.mentorships,_that.trainings,_that.coaching,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OverviewActions implements OverviewActions {
  const _OverviewActions({required this.promotions, required this.recognitions, required this.mentorships, required this.trainings, required this.coaching, required this.total});
  factory _OverviewActions.fromJson(Map<String, dynamic> json) => _$OverviewActionsFromJson(json);

@override final  int promotions;
@override final  int recognitions;
@override final  int mentorships;
@override final  int trainings;
@override final  int coaching;
@override final  int total;

/// Create a copy of OverviewActions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewActionsCopyWith<_OverviewActions> get copyWith => __$OverviewActionsCopyWithImpl<_OverviewActions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverviewActionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewActions&&(identical(other.promotions, promotions) || other.promotions == promotions)&&(identical(other.recognitions, recognitions) || other.recognitions == recognitions)&&(identical(other.mentorships, mentorships) || other.mentorships == mentorships)&&(identical(other.trainings, trainings) || other.trainings == trainings)&&(identical(other.coaching, coaching) || other.coaching == coaching)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,promotions,recognitions,mentorships,trainings,coaching,total);

@override
String toString() {
  return 'OverviewActions(promotions: $promotions, recognitions: $recognitions, mentorships: $mentorships, trainings: $trainings, coaching: $coaching, total: $total)';
}


}

/// @nodoc
abstract mixin class _$OverviewActionsCopyWith<$Res> implements $OverviewActionsCopyWith<$Res> {
  factory _$OverviewActionsCopyWith(_OverviewActions value, $Res Function(_OverviewActions) _then) = __$OverviewActionsCopyWithImpl;
@override @useResult
$Res call({
 int promotions, int recognitions, int mentorships, int trainings, int coaching, int total
});




}
/// @nodoc
class __$OverviewActionsCopyWithImpl<$Res>
    implements _$OverviewActionsCopyWith<$Res> {
  __$OverviewActionsCopyWithImpl(this._self, this._then);

  final _OverviewActions _self;
  final $Res Function(_OverviewActions) _then;

/// Create a copy of OverviewActions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? promotions = null,Object? recognitions = null,Object? mentorships = null,Object? trainings = null,Object? coaching = null,Object? total = null,}) {
  return _then(_OverviewActions(
promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as int,recognitions: null == recognitions ? _self.recognitions : recognitions // ignore: cast_nullable_to_non_nullable
as int,mentorships: null == mentorships ? _self.mentorships : mentorships // ignore: cast_nullable_to_non_nullable
as int,trainings: null == trainings ? _self.trainings : trainings // ignore: cast_nullable_to_non_nullable
as int,coaching: null == coaching ? _self.coaching : coaching // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
