// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlertPreviewModel {

@JsonKey(name: 'top_alerts') List<AlertItem> get topAlerts;@JsonKey(name: 'stats') AlertStats? get stats;
/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertPreviewModelCopyWith<AlertPreviewModel> get copyWith => _$AlertPreviewModelCopyWithImpl<AlertPreviewModel>(this as AlertPreviewModel, _$identity);

  /// Serializes this AlertPreviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertPreviewModel&&const DeepCollectionEquality().equals(other.topAlerts, topAlerts)&&(identical(other.stats, stats) || other.stats == stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(topAlerts),stats);

@override
String toString() {
  return 'AlertPreviewModel(topAlerts: $topAlerts, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $AlertPreviewModelCopyWith<$Res>  {
  factory $AlertPreviewModelCopyWith(AlertPreviewModel value, $Res Function(AlertPreviewModel) _then) = _$AlertPreviewModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'top_alerts') List<AlertItem> topAlerts,@JsonKey(name: 'stats') AlertStats? stats
});


$AlertStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class _$AlertPreviewModelCopyWithImpl<$Res>
    implements $AlertPreviewModelCopyWith<$Res> {
  _$AlertPreviewModelCopyWithImpl(this._self, this._then);

  final AlertPreviewModel _self;
  final $Res Function(AlertPreviewModel) _then;

/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topAlerts = null,Object? stats = freezed,}) {
  return _then(_self.copyWith(
topAlerts: null == topAlerts ? _self.topAlerts : topAlerts // ignore: cast_nullable_to_non_nullable
as List<AlertItem>,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as AlertStats?,
  ));
}
/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $AlertStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [AlertPreviewModel].
extension AlertPreviewModelPatterns on AlertPreviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertPreviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertPreviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertPreviewModel value)  $default,){
final _that = this;
switch (_that) {
case _AlertPreviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertPreviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _AlertPreviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'top_alerts')  List<AlertItem> topAlerts, @JsonKey(name: 'stats')  AlertStats? stats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertPreviewModel() when $default != null:
return $default(_that.topAlerts,_that.stats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'top_alerts')  List<AlertItem> topAlerts, @JsonKey(name: 'stats')  AlertStats? stats)  $default,) {final _that = this;
switch (_that) {
case _AlertPreviewModel():
return $default(_that.topAlerts,_that.stats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'top_alerts')  List<AlertItem> topAlerts, @JsonKey(name: 'stats')  AlertStats? stats)?  $default,) {final _that = this;
switch (_that) {
case _AlertPreviewModel() when $default != null:
return $default(_that.topAlerts,_that.stats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlertPreviewModel implements AlertPreviewModel {
  const _AlertPreviewModel({@JsonKey(name: 'top_alerts') final  List<AlertItem> topAlerts = const [], @JsonKey(name: 'stats') this.stats}): _topAlerts = topAlerts;
  factory _AlertPreviewModel.fromJson(Map<String, dynamic> json) => _$AlertPreviewModelFromJson(json);

 final  List<AlertItem> _topAlerts;
@override@JsonKey(name: 'top_alerts') List<AlertItem> get topAlerts {
  if (_topAlerts is EqualUnmodifiableListView) return _topAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topAlerts);
}

@override@JsonKey(name: 'stats') final  AlertStats? stats;

/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertPreviewModelCopyWith<_AlertPreviewModel> get copyWith => __$AlertPreviewModelCopyWithImpl<_AlertPreviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertPreviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertPreviewModel&&const DeepCollectionEquality().equals(other._topAlerts, _topAlerts)&&(identical(other.stats, stats) || other.stats == stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topAlerts),stats);

@override
String toString() {
  return 'AlertPreviewModel(topAlerts: $topAlerts, stats: $stats)';
}


}

/// @nodoc
abstract mixin class _$AlertPreviewModelCopyWith<$Res> implements $AlertPreviewModelCopyWith<$Res> {
  factory _$AlertPreviewModelCopyWith(_AlertPreviewModel value, $Res Function(_AlertPreviewModel) _then) = __$AlertPreviewModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'top_alerts') List<AlertItem> topAlerts,@JsonKey(name: 'stats') AlertStats? stats
});


@override $AlertStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class __$AlertPreviewModelCopyWithImpl<$Res>
    implements _$AlertPreviewModelCopyWith<$Res> {
  __$AlertPreviewModelCopyWithImpl(this._self, this._then);

  final _AlertPreviewModel _self;
  final $Res Function(_AlertPreviewModel) _then;

/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topAlerts = null,Object? stats = freezed,}) {
  return _then(_AlertPreviewModel(
topAlerts: null == topAlerts ? _self._topAlerts : topAlerts // ignore: cast_nullable_to_non_nullable
as List<AlertItem>,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as AlertStats?,
  ));
}

/// Create a copy of AlertPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $AlertStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// @nodoc
mixin _$AlertItem {

 String get id; String get type; String get severity; String get title;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of AlertItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertItemCopyWith<AlertItem> get copyWith => _$AlertItemCopyWithImpl<AlertItem>(this as AlertItem, _$identity);

  /// Serializes this AlertItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,createdAt);

@override
String toString() {
  return 'AlertItem(id: $id, type: $type, severity: $severity, title: $title, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AlertItemCopyWith<$Res>  {
  factory $AlertItemCopyWith(AlertItem value, $Res Function(AlertItem) _then) = _$AlertItemCopyWithImpl;
@useResult
$Res call({
 String id, String type, String severity, String title,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AlertItemCopyWithImpl<$Res>
    implements $AlertItemCopyWith<$Res> {
  _$AlertItemCopyWithImpl(this._self, this._then);

  final AlertItem _self;
  final $Res Function(AlertItem) _then;

/// Create a copy of AlertItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertItem].
extension AlertItemPatterns on AlertItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertItem value)  $default,){
final _that = this;
switch (_that) {
case _AlertItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertItem value)?  $default,){
final _that = this;
switch (_that) {
case _AlertItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String severity,  String title, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertItem() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String severity,  String title, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AlertItem():
return $default(_that.id,_that.type,_that.severity,_that.title,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String severity,  String title, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AlertItem() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlertItem implements AlertItem {
  const _AlertItem({required this.id, required this.type, required this.severity, required this.title, @JsonKey(name: 'created_at') required this.createdAt});
  factory _AlertItem.fromJson(Map<String, dynamic> json) => _$AlertItemFromJson(json);

@override final  String id;
@override final  String type;
@override final  String severity;
@override final  String title;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of AlertItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertItemCopyWith<_AlertItem> get copyWith => __$AlertItemCopyWithImpl<_AlertItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,createdAt);

@override
String toString() {
  return 'AlertItem(id: $id, type: $type, severity: $severity, title: $title, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AlertItemCopyWith<$Res> implements $AlertItemCopyWith<$Res> {
  factory _$AlertItemCopyWith(_AlertItem value, $Res Function(_AlertItem) _then) = __$AlertItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String severity, String title,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AlertItemCopyWithImpl<$Res>
    implements _$AlertItemCopyWith<$Res> {
  __$AlertItemCopyWithImpl(this._self, this._then);

  final _AlertItem _self;
  final $Res Function(_AlertItem) _then;

/// Create a copy of AlertItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? createdAt = null,}) {
  return _then(_AlertItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$AlertStats {

@JsonKey(name: 'high_risk_count') int get highRiskCount;@JsonKey(name: 'promotion_count') int get promotionCount;@JsonKey(name: 'recognition_count') int get recognitionCount;
/// Create a copy of AlertStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertStatsCopyWith<AlertStats> get copyWith => _$AlertStatsCopyWithImpl<AlertStats>(this as AlertStats, _$identity);

  /// Serializes this AlertStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertStats&&(identical(other.highRiskCount, highRiskCount) || other.highRiskCount == highRiskCount)&&(identical(other.promotionCount, promotionCount) || other.promotionCount == promotionCount)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highRiskCount,promotionCount,recognitionCount);

@override
String toString() {
  return 'AlertStats(highRiskCount: $highRiskCount, promotionCount: $promotionCount, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class $AlertStatsCopyWith<$Res>  {
  factory $AlertStatsCopyWith(AlertStats value, $Res Function(AlertStats) _then) = _$AlertStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'high_risk_count') int highRiskCount,@JsonKey(name: 'promotion_count') int promotionCount,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class _$AlertStatsCopyWithImpl<$Res>
    implements $AlertStatsCopyWith<$Res> {
  _$AlertStatsCopyWithImpl(this._self, this._then);

  final AlertStats _self;
  final $Res Function(AlertStats) _then;

/// Create a copy of AlertStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? highRiskCount = null,Object? promotionCount = null,Object? recognitionCount = null,}) {
  return _then(_self.copyWith(
highRiskCount: null == highRiskCount ? _self.highRiskCount : highRiskCount // ignore: cast_nullable_to_non_nullable
as int,promotionCount: null == promotionCount ? _self.promotionCount : promotionCount // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertStats].
extension AlertStatsPatterns on AlertStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertStats value)  $default,){
final _that = this;
switch (_that) {
case _AlertStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertStats value)?  $default,){
final _that = this;
switch (_that) {
case _AlertStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'high_risk_count')  int highRiskCount, @JsonKey(name: 'promotion_count')  int promotionCount, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertStats() when $default != null:
return $default(_that.highRiskCount,_that.promotionCount,_that.recognitionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'high_risk_count')  int highRiskCount, @JsonKey(name: 'promotion_count')  int promotionCount, @JsonKey(name: 'recognition_count')  int recognitionCount)  $default,) {final _that = this;
switch (_that) {
case _AlertStats():
return $default(_that.highRiskCount,_that.promotionCount,_that.recognitionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'high_risk_count')  int highRiskCount, @JsonKey(name: 'promotion_count')  int promotionCount, @JsonKey(name: 'recognition_count')  int recognitionCount)?  $default,) {final _that = this;
switch (_that) {
case _AlertStats() when $default != null:
return $default(_that.highRiskCount,_that.promotionCount,_that.recognitionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlertStats implements AlertStats {
  const _AlertStats({@JsonKey(name: 'high_risk_count') required this.highRiskCount, @JsonKey(name: 'promotion_count') required this.promotionCount, @JsonKey(name: 'recognition_count') required this.recognitionCount});
  factory _AlertStats.fromJson(Map<String, dynamic> json) => _$AlertStatsFromJson(json);

@override@JsonKey(name: 'high_risk_count') final  int highRiskCount;
@override@JsonKey(name: 'promotion_count') final  int promotionCount;
@override@JsonKey(name: 'recognition_count') final  int recognitionCount;

/// Create a copy of AlertStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertStatsCopyWith<_AlertStats> get copyWith => __$AlertStatsCopyWithImpl<_AlertStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertStats&&(identical(other.highRiskCount, highRiskCount) || other.highRiskCount == highRiskCount)&&(identical(other.promotionCount, promotionCount) || other.promotionCount == promotionCount)&&(identical(other.recognitionCount, recognitionCount) || other.recognitionCount == recognitionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,highRiskCount,promotionCount,recognitionCount);

@override
String toString() {
  return 'AlertStats(highRiskCount: $highRiskCount, promotionCount: $promotionCount, recognitionCount: $recognitionCount)';
}


}

/// @nodoc
abstract mixin class _$AlertStatsCopyWith<$Res> implements $AlertStatsCopyWith<$Res> {
  factory _$AlertStatsCopyWith(_AlertStats value, $Res Function(_AlertStats) _then) = __$AlertStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'high_risk_count') int highRiskCount,@JsonKey(name: 'promotion_count') int promotionCount,@JsonKey(name: 'recognition_count') int recognitionCount
});




}
/// @nodoc
class __$AlertStatsCopyWithImpl<$Res>
    implements _$AlertStatsCopyWith<$Res> {
  __$AlertStatsCopyWithImpl(this._self, this._then);

  final _AlertStats _self;
  final $Res Function(_AlertStats) _then;

/// Create a copy of AlertStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? highRiskCount = null,Object? promotionCount = null,Object? recognitionCount = null,}) {
  return _then(_AlertStats(
highRiskCount: null == highRiskCount ? _self.highRiskCount : highRiskCount // ignore: cast_nullable_to_non_nullable
as int,promotionCount: null == promotionCount ? _self.promotionCount : promotionCount // ignore: cast_nullable_to_non_nullable
as int,recognitionCount: null == recognitionCount ? _self.recognitionCount : recognitionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
