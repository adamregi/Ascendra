// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecommendationPreviewModel {

@JsonKey(name: 'promotions') List<RecommendationItem> get promotions;@JsonKey(name: 'mentorships') List<RecommendationItem> get mentorships;@JsonKey(name: 'coaching') List<RecommendationItem> get coaching;@JsonKey(name: 'training') List<RecommendationItem> get training;@JsonKey(name: 'recognitions') List<RecommendationItem> get recognitions;
/// Create a copy of RecommendationPreviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendationPreviewModelCopyWith<RecommendationPreviewModel> get copyWith => _$RecommendationPreviewModelCopyWithImpl<RecommendationPreviewModel>(this as RecommendationPreviewModel, _$identity);

  /// Serializes this RecommendationPreviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendationPreviewModel&&const DeepCollectionEquality().equals(other.promotions, promotions)&&const DeepCollectionEquality().equals(other.mentorships, mentorships)&&const DeepCollectionEquality().equals(other.coaching, coaching)&&const DeepCollectionEquality().equals(other.training, training)&&const DeepCollectionEquality().equals(other.recognitions, recognitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(promotions),const DeepCollectionEquality().hash(mentorships),const DeepCollectionEquality().hash(coaching),const DeepCollectionEquality().hash(training),const DeepCollectionEquality().hash(recognitions));

@override
String toString() {
  return 'RecommendationPreviewModel(promotions: $promotions, mentorships: $mentorships, coaching: $coaching, training: $training, recognitions: $recognitions)';
}


}

/// @nodoc
abstract mixin class $RecommendationPreviewModelCopyWith<$Res>  {
  factory $RecommendationPreviewModelCopyWith(RecommendationPreviewModel value, $Res Function(RecommendationPreviewModel) _then) = _$RecommendationPreviewModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'promotions') List<RecommendationItem> promotions,@JsonKey(name: 'mentorships') List<RecommendationItem> mentorships,@JsonKey(name: 'coaching') List<RecommendationItem> coaching,@JsonKey(name: 'training') List<RecommendationItem> training,@JsonKey(name: 'recognitions') List<RecommendationItem> recognitions
});




}
/// @nodoc
class _$RecommendationPreviewModelCopyWithImpl<$Res>
    implements $RecommendationPreviewModelCopyWith<$Res> {
  _$RecommendationPreviewModelCopyWithImpl(this._self, this._then);

  final RecommendationPreviewModel _self;
  final $Res Function(RecommendationPreviewModel) _then;

/// Create a copy of RecommendationPreviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? promotions = null,Object? mentorships = null,Object? coaching = null,Object? training = null,Object? recognitions = null,}) {
  return _then(_self.copyWith(
promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,mentorships: null == mentorships ? _self.mentorships : mentorships // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,coaching: null == coaching ? _self.coaching : coaching // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,training: null == training ? _self.training : training // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,recognitions: null == recognitions ? _self.recognitions : recognitions // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendationPreviewModel].
extension RecommendationPreviewModelPatterns on RecommendationPreviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendationPreviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendationPreviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendationPreviewModel value)  $default,){
final _that = this;
switch (_that) {
case _RecommendationPreviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendationPreviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendationPreviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'promotions')  List<RecommendationItem> promotions, @JsonKey(name: 'mentorships')  List<RecommendationItem> mentorships, @JsonKey(name: 'coaching')  List<RecommendationItem> coaching, @JsonKey(name: 'training')  List<RecommendationItem> training, @JsonKey(name: 'recognitions')  List<RecommendationItem> recognitions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendationPreviewModel() when $default != null:
return $default(_that.promotions,_that.mentorships,_that.coaching,_that.training,_that.recognitions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'promotions')  List<RecommendationItem> promotions, @JsonKey(name: 'mentorships')  List<RecommendationItem> mentorships, @JsonKey(name: 'coaching')  List<RecommendationItem> coaching, @JsonKey(name: 'training')  List<RecommendationItem> training, @JsonKey(name: 'recognitions')  List<RecommendationItem> recognitions)  $default,) {final _that = this;
switch (_that) {
case _RecommendationPreviewModel():
return $default(_that.promotions,_that.mentorships,_that.coaching,_that.training,_that.recognitions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'promotions')  List<RecommendationItem> promotions, @JsonKey(name: 'mentorships')  List<RecommendationItem> mentorships, @JsonKey(name: 'coaching')  List<RecommendationItem> coaching, @JsonKey(name: 'training')  List<RecommendationItem> training, @JsonKey(name: 'recognitions')  List<RecommendationItem> recognitions)?  $default,) {final _that = this;
switch (_that) {
case _RecommendationPreviewModel() when $default != null:
return $default(_that.promotions,_that.mentorships,_that.coaching,_that.training,_that.recognitions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecommendationPreviewModel implements RecommendationPreviewModel {
  const _RecommendationPreviewModel({@JsonKey(name: 'promotions') final  List<RecommendationItem> promotions = const [], @JsonKey(name: 'mentorships') final  List<RecommendationItem> mentorships = const [], @JsonKey(name: 'coaching') final  List<RecommendationItem> coaching = const [], @JsonKey(name: 'training') final  List<RecommendationItem> training = const [], @JsonKey(name: 'recognitions') final  List<RecommendationItem> recognitions = const []}): _promotions = promotions,_mentorships = mentorships,_coaching = coaching,_training = training,_recognitions = recognitions;
  factory _RecommendationPreviewModel.fromJson(Map<String, dynamic> json) => _$RecommendationPreviewModelFromJson(json);

 final  List<RecommendationItem> _promotions;
@override@JsonKey(name: 'promotions') List<RecommendationItem> get promotions {
  if (_promotions is EqualUnmodifiableListView) return _promotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_promotions);
}

 final  List<RecommendationItem> _mentorships;
@override@JsonKey(name: 'mentorships') List<RecommendationItem> get mentorships {
  if (_mentorships is EqualUnmodifiableListView) return _mentorships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentorships);
}

 final  List<RecommendationItem> _coaching;
@override@JsonKey(name: 'coaching') List<RecommendationItem> get coaching {
  if (_coaching is EqualUnmodifiableListView) return _coaching;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coaching);
}

 final  List<RecommendationItem> _training;
@override@JsonKey(name: 'training') List<RecommendationItem> get training {
  if (_training is EqualUnmodifiableListView) return _training;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_training);
}

 final  List<RecommendationItem> _recognitions;
@override@JsonKey(name: 'recognitions') List<RecommendationItem> get recognitions {
  if (_recognitions is EqualUnmodifiableListView) return _recognitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recognitions);
}


/// Create a copy of RecommendationPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendationPreviewModelCopyWith<_RecommendationPreviewModel> get copyWith => __$RecommendationPreviewModelCopyWithImpl<_RecommendationPreviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendationPreviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendationPreviewModel&&const DeepCollectionEquality().equals(other._promotions, _promotions)&&const DeepCollectionEquality().equals(other._mentorships, _mentorships)&&const DeepCollectionEquality().equals(other._coaching, _coaching)&&const DeepCollectionEquality().equals(other._training, _training)&&const DeepCollectionEquality().equals(other._recognitions, _recognitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_promotions),const DeepCollectionEquality().hash(_mentorships),const DeepCollectionEquality().hash(_coaching),const DeepCollectionEquality().hash(_training),const DeepCollectionEquality().hash(_recognitions));

@override
String toString() {
  return 'RecommendationPreviewModel(promotions: $promotions, mentorships: $mentorships, coaching: $coaching, training: $training, recognitions: $recognitions)';
}


}

/// @nodoc
abstract mixin class _$RecommendationPreviewModelCopyWith<$Res> implements $RecommendationPreviewModelCopyWith<$Res> {
  factory _$RecommendationPreviewModelCopyWith(_RecommendationPreviewModel value, $Res Function(_RecommendationPreviewModel) _then) = __$RecommendationPreviewModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'promotions') List<RecommendationItem> promotions,@JsonKey(name: 'mentorships') List<RecommendationItem> mentorships,@JsonKey(name: 'coaching') List<RecommendationItem> coaching,@JsonKey(name: 'training') List<RecommendationItem> training,@JsonKey(name: 'recognitions') List<RecommendationItem> recognitions
});




}
/// @nodoc
class __$RecommendationPreviewModelCopyWithImpl<$Res>
    implements _$RecommendationPreviewModelCopyWith<$Res> {
  __$RecommendationPreviewModelCopyWithImpl(this._self, this._then);

  final _RecommendationPreviewModel _self;
  final $Res Function(_RecommendationPreviewModel) _then;

/// Create a copy of RecommendationPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? promotions = null,Object? mentorships = null,Object? coaching = null,Object? training = null,Object? recognitions = null,}) {
  return _then(_RecommendationPreviewModel(
promotions: null == promotions ? _self._promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,mentorships: null == mentorships ? _self._mentorships : mentorships // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,coaching: null == coaching ? _self._coaching : coaching // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,training: null == training ? _self._training : training // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,recognitions: null == recognitions ? _self._recognitions : recognitions // ignore: cast_nullable_to_non_nullable
as List<RecommendationItem>,
  ));
}


}


/// @nodoc
mixin _$RecommendationItem {

@JsonKey(name: 'recommendation_id') String get recommendationId;@JsonKey(name: 'member_name') String get memberName;@JsonKey(name: 'confidence_score') double get confidenceScore; String get reasoning;@JsonKey(name: 'current_leadership_score') double get currentLeadershipScore;@JsonKey(name: 'created_at') DateTime get createdAt;// Optional fields that only some types have
@JsonKey(name: 'recommended_role') String? get recommendedRole;@JsonKey(name: 'current_risk_level') String? get currentRiskLevel;
/// Create a copy of RecommendationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendationItemCopyWith<RecommendationItem> get copyWith => _$RecommendationItemCopyWithImpl<RecommendationItem>(this as RecommendationItem, _$identity);

  /// Serializes this RecommendationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendationItem&&(identical(other.recommendationId, recommendationId) || other.recommendationId == recommendationId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.currentLeadershipScore, currentLeadershipScore) || other.currentLeadershipScore == currentLeadershipScore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.recommendedRole, recommendedRole) || other.recommendedRole == recommendedRole)&&(identical(other.currentRiskLevel, currentRiskLevel) || other.currentRiskLevel == currentRiskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recommendationId,memberName,confidenceScore,reasoning,currentLeadershipScore,createdAt,recommendedRole,currentRiskLevel);

@override
String toString() {
  return 'RecommendationItem(recommendationId: $recommendationId, memberName: $memberName, confidenceScore: $confidenceScore, reasoning: $reasoning, currentLeadershipScore: $currentLeadershipScore, createdAt: $createdAt, recommendedRole: $recommendedRole, currentRiskLevel: $currentRiskLevel)';
}


}

/// @nodoc
abstract mixin class $RecommendationItemCopyWith<$Res>  {
  factory $RecommendationItemCopyWith(RecommendationItem value, $Res Function(RecommendationItem) _then) = _$RecommendationItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'recommendation_id') String recommendationId,@JsonKey(name: 'member_name') String memberName,@JsonKey(name: 'confidence_score') double confidenceScore, String reasoning,@JsonKey(name: 'current_leadership_score') double currentLeadershipScore,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'recommended_role') String? recommendedRole,@JsonKey(name: 'current_risk_level') String? currentRiskLevel
});




}
/// @nodoc
class _$RecommendationItemCopyWithImpl<$Res>
    implements $RecommendationItemCopyWith<$Res> {
  _$RecommendationItemCopyWithImpl(this._self, this._then);

  final RecommendationItem _self;
  final $Res Function(RecommendationItem) _then;

/// Create a copy of RecommendationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recommendationId = null,Object? memberName = null,Object? confidenceScore = null,Object? reasoning = null,Object? currentLeadershipScore = null,Object? createdAt = null,Object? recommendedRole = freezed,Object? currentRiskLevel = freezed,}) {
  return _then(_self.copyWith(
recommendationId: null == recommendationId ? _self.recommendationId : recommendationId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,currentLeadershipScore: null == currentLeadershipScore ? _self.currentLeadershipScore : currentLeadershipScore // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,recommendedRole: freezed == recommendedRole ? _self.recommendedRole : recommendedRole // ignore: cast_nullable_to_non_nullable
as String?,currentRiskLevel: freezed == currentRiskLevel ? _self.currentRiskLevel : currentRiskLevel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendationItem].
extension RecommendationItemPatterns on RecommendationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendationItem value)  $default,){
final _that = this;
switch (_that) {
case _RecommendationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendationItem value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'recommendation_id')  String recommendationId, @JsonKey(name: 'member_name')  String memberName, @JsonKey(name: 'confidence_score')  double confidenceScore,  String reasoning, @JsonKey(name: 'current_leadership_score')  double currentLeadershipScore, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'recommended_role')  String? recommendedRole, @JsonKey(name: 'current_risk_level')  String? currentRiskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendationItem() when $default != null:
return $default(_that.recommendationId,_that.memberName,_that.confidenceScore,_that.reasoning,_that.currentLeadershipScore,_that.createdAt,_that.recommendedRole,_that.currentRiskLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'recommendation_id')  String recommendationId, @JsonKey(name: 'member_name')  String memberName, @JsonKey(name: 'confidence_score')  double confidenceScore,  String reasoning, @JsonKey(name: 'current_leadership_score')  double currentLeadershipScore, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'recommended_role')  String? recommendedRole, @JsonKey(name: 'current_risk_level')  String? currentRiskLevel)  $default,) {final _that = this;
switch (_that) {
case _RecommendationItem():
return $default(_that.recommendationId,_that.memberName,_that.confidenceScore,_that.reasoning,_that.currentLeadershipScore,_that.createdAt,_that.recommendedRole,_that.currentRiskLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'recommendation_id')  String recommendationId, @JsonKey(name: 'member_name')  String memberName, @JsonKey(name: 'confidence_score')  double confidenceScore,  String reasoning, @JsonKey(name: 'current_leadership_score')  double currentLeadershipScore, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'recommended_role')  String? recommendedRole, @JsonKey(name: 'current_risk_level')  String? currentRiskLevel)?  $default,) {final _that = this;
switch (_that) {
case _RecommendationItem() when $default != null:
return $default(_that.recommendationId,_that.memberName,_that.confidenceScore,_that.reasoning,_that.currentLeadershipScore,_that.createdAt,_that.recommendedRole,_that.currentRiskLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecommendationItem implements RecommendationItem {
  const _RecommendationItem({@JsonKey(name: 'recommendation_id') required this.recommendationId, @JsonKey(name: 'member_name') required this.memberName, @JsonKey(name: 'confidence_score') required this.confidenceScore, required this.reasoning, @JsonKey(name: 'current_leadership_score') required this.currentLeadershipScore, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'recommended_role') this.recommendedRole, @JsonKey(name: 'current_risk_level') this.currentRiskLevel});
  factory _RecommendationItem.fromJson(Map<String, dynamic> json) => _$RecommendationItemFromJson(json);

@override@JsonKey(name: 'recommendation_id') final  String recommendationId;
@override@JsonKey(name: 'member_name') final  String memberName;
@override@JsonKey(name: 'confidence_score') final  double confidenceScore;
@override final  String reasoning;
@override@JsonKey(name: 'current_leadership_score') final  double currentLeadershipScore;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
// Optional fields that only some types have
@override@JsonKey(name: 'recommended_role') final  String? recommendedRole;
@override@JsonKey(name: 'current_risk_level') final  String? currentRiskLevel;

/// Create a copy of RecommendationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendationItemCopyWith<_RecommendationItem> get copyWith => __$RecommendationItemCopyWithImpl<_RecommendationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendationItem&&(identical(other.recommendationId, recommendationId) || other.recommendationId == recommendationId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.currentLeadershipScore, currentLeadershipScore) || other.currentLeadershipScore == currentLeadershipScore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.recommendedRole, recommendedRole) || other.recommendedRole == recommendedRole)&&(identical(other.currentRiskLevel, currentRiskLevel) || other.currentRiskLevel == currentRiskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recommendationId,memberName,confidenceScore,reasoning,currentLeadershipScore,createdAt,recommendedRole,currentRiskLevel);

@override
String toString() {
  return 'RecommendationItem(recommendationId: $recommendationId, memberName: $memberName, confidenceScore: $confidenceScore, reasoning: $reasoning, currentLeadershipScore: $currentLeadershipScore, createdAt: $createdAt, recommendedRole: $recommendedRole, currentRiskLevel: $currentRiskLevel)';
}


}

/// @nodoc
abstract mixin class _$RecommendationItemCopyWith<$Res> implements $RecommendationItemCopyWith<$Res> {
  factory _$RecommendationItemCopyWith(_RecommendationItem value, $Res Function(_RecommendationItem) _then) = __$RecommendationItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'recommendation_id') String recommendationId,@JsonKey(name: 'member_name') String memberName,@JsonKey(name: 'confidence_score') double confidenceScore, String reasoning,@JsonKey(name: 'current_leadership_score') double currentLeadershipScore,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'recommended_role') String? recommendedRole,@JsonKey(name: 'current_risk_level') String? currentRiskLevel
});




}
/// @nodoc
class __$RecommendationItemCopyWithImpl<$Res>
    implements _$RecommendationItemCopyWith<$Res> {
  __$RecommendationItemCopyWithImpl(this._self, this._then);

  final _RecommendationItem _self;
  final $Res Function(_RecommendationItem) _then;

/// Create a copy of RecommendationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recommendationId = null,Object? memberName = null,Object? confidenceScore = null,Object? reasoning = null,Object? currentLeadershipScore = null,Object? createdAt = null,Object? recommendedRole = freezed,Object? currentRiskLevel = freezed,}) {
  return _then(_RecommendationItem(
recommendationId: null == recommendationId ? _self.recommendationId : recommendationId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,currentLeadershipScore: null == currentLeadershipScore ? _self.currentLeadershipScore : currentLeadershipScore // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,recommendedRole: freezed == recommendedRole ? _self.recommendedRole : recommendedRole // ignore: cast_nullable_to_non_nullable
as String?,currentRiskLevel: freezed == currentRiskLevel ? _self.currentRiskLevel : currentRiskLevel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
