// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_recognition_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberRecognitionModel {

 String get name; String get description;@JsonKey(name: 'earned_date') DateTime get earnedDate; String get category; String get icon; int get level; int get points;
/// Create a copy of MemberRecognitionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberRecognitionModelCopyWith<MemberRecognitionModel> get copyWith => _$MemberRecognitionModelCopyWithImpl<MemberRecognitionModel>(this as MemberRecognitionModel, _$identity);

  /// Serializes this MemberRecognitionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRecognitionModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberRecognitionModel(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class $MemberRecognitionModelCopyWith<$Res>  {
  factory $MemberRecognitionModelCopyWith(MemberRecognitionModel value, $Res Function(MemberRecognitionModel) _then) = _$MemberRecognitionModelCopyWithImpl;
@useResult
$Res call({
 String name, String description,@JsonKey(name: 'earned_date') DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class _$MemberRecognitionModelCopyWithImpl<$Res>
    implements $MemberRecognitionModelCopyWith<$Res> {
  _$MemberRecognitionModelCopyWithImpl(this._self, this._then);

  final MemberRecognitionModel _self;
  final $Res Function(MemberRecognitionModel) _then;

/// Create a copy of MemberRecognitionModel
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


/// Adds pattern-matching-related methods to [MemberRecognitionModel].
extension MemberRecognitionModelPatterns on MemberRecognitionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberRecognitionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberRecognitionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberRecognitionModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberRecognitionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberRecognitionModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberRecognitionModel() when $default != null:
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
case _MemberRecognitionModel() when $default != null:
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
case _MemberRecognitionModel():
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
case _MemberRecognitionModel() when $default != null:
return $default(_that.name,_that.description,_that.earnedDate,_that.category,_that.icon,_that.level,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberRecognitionModel implements MemberRecognitionModel {
  const _MemberRecognitionModel({required this.name, required this.description, @JsonKey(name: 'earned_date') required this.earnedDate, required this.category, required this.icon, required this.level, required this.points});
  factory _MemberRecognitionModel.fromJson(Map<String, dynamic> json) => _$MemberRecognitionModelFromJson(json);

@override final  String name;
@override final  String description;
@override@JsonKey(name: 'earned_date') final  DateTime earnedDate;
@override final  String category;
@override final  String icon;
@override final  int level;
@override final  int points;

/// Create a copy of MemberRecognitionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberRecognitionModelCopyWith<_MemberRecognitionModel> get copyWith => __$MemberRecognitionModelCopyWithImpl<_MemberRecognitionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberRecognitionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberRecognitionModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earnedDate, earnedDate) || other.earnedDate == earnedDate)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.level, level) || other.level == level)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,earnedDate,category,icon,level,points);

@override
String toString() {
  return 'MemberRecognitionModel(name: $name, description: $description, earnedDate: $earnedDate, category: $category, icon: $icon, level: $level, points: $points)';
}


}

/// @nodoc
abstract mixin class _$MemberRecognitionModelCopyWith<$Res> implements $MemberRecognitionModelCopyWith<$Res> {
  factory _$MemberRecognitionModelCopyWith(_MemberRecognitionModel value, $Res Function(_MemberRecognitionModel) _then) = __$MemberRecognitionModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String description,@JsonKey(name: 'earned_date') DateTime earnedDate, String category, String icon, int level, int points
});




}
/// @nodoc
class __$MemberRecognitionModelCopyWithImpl<$Res>
    implements _$MemberRecognitionModelCopyWith<$Res> {
  __$MemberRecognitionModelCopyWithImpl(this._self, this._then);

  final _MemberRecognitionModel _self;
  final $Res Function(_MemberRecognitionModel) _then;

/// Create a copy of MemberRecognitionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? earnedDate = null,Object? category = null,Object? icon = null,Object? level = null,Object? points = null,}) {
  return _then(_MemberRecognitionModel(
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

// dart format on
