// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id;@JsonKey(name: 'company_id') String get companyId; String get title; String? get description; String get priority;// 'high', 'medium', 'low'
 String get status;// 'open', 'in_progress', 'completed', 'overdue', 'cancelled'
@JsonKey(name: 'due_date') DateTime? get dueDate;@JsonKey(name: 'created_by') String get createdBy;@JsonKey(name: 'assigned_to') List<String> get assignedTo;@JsonKey(name: 'proof_required') bool get proofRequired;@JsonKey(name: 'proof_type') String get proofType;// 'text', 'image', 'pdf', 'url'
@JsonKey(name: 'completion_rule') String? get completionRule; List<String> get attachments; List<String> get tags;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.assignedTo, assignedTo)&&(identical(other.proofRequired, proofRequired) || other.proofRequired == proofRequired)&&(identical(other.proofType, proofType) || other.proofType == proofType)&&(identical(other.completionRule, completionRule) || other.completionRule == completionRule)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,title,description,priority,status,dueDate,createdBy,const DeepCollectionEquality().hash(assignedTo),proofRequired,proofType,completionRule,const DeepCollectionEquality().hash(attachments),const DeepCollectionEquality().hash(tags),createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, companyId: $companyId, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, createdBy: $createdBy, assignedTo: $assignedTo, proofRequired: $proofRequired, proofType: $proofType, completionRule: $completionRule, attachments: $attachments, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'company_id') String companyId, String title, String? description, String priority, String status,@JsonKey(name: 'due_date') DateTime? dueDate,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'assigned_to') List<String> assignedTo,@JsonKey(name: 'proof_required') bool proofRequired,@JsonKey(name: 'proof_type') String proofType,@JsonKey(name: 'completion_rule') String? completionRule, List<String> attachments, List<String> tags,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? dueDate = freezed,Object? createdBy = null,Object? assignedTo = null,Object? proofRequired = null,Object? proofType = null,Object? completionRule = freezed,Object? attachments = null,Object? tags = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,assignedTo: null == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>,proofRequired: null == proofRequired ? _self.proofRequired : proofRequired // ignore: cast_nullable_to_non_nullable
as bool,proofType: null == proofType ? _self.proofType : proofType // ignore: cast_nullable_to_non_nullable
as String,completionRule: freezed == completionRule ? _self.completionRule : completionRule // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String priority,  String status, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'assigned_to')  List<String> assignedTo, @JsonKey(name: 'proof_required')  bool proofRequired, @JsonKey(name: 'proof_type')  String proofType, @JsonKey(name: 'completion_rule')  String? completionRule,  List<String> attachments,  List<String> tags, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.priority,_that.status,_that.dueDate,_that.createdBy,_that.assignedTo,_that.proofRequired,_that.proofType,_that.completionRule,_that.attachments,_that.tags,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String priority,  String status, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'assigned_to')  List<String> assignedTo, @JsonKey(name: 'proof_required')  bool proofRequired, @JsonKey(name: 'proof_type')  String proofType, @JsonKey(name: 'completion_rule')  String? completionRule,  List<String> attachments,  List<String> tags, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.priority,_that.status,_that.dueDate,_that.createdBy,_that.assignedTo,_that.proofRequired,_that.proofType,_that.completionRule,_that.attachments,_that.tags,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'company_id')  String companyId,  String title,  String? description,  String priority,  String status, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'assigned_to')  List<String> assignedTo, @JsonKey(name: 'proof_required')  bool proofRequired, @JsonKey(name: 'proof_type')  String proofType, @JsonKey(name: 'completion_rule')  String? completionRule,  List<String> attachments,  List<String> tags, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.companyId,_that.title,_that.description,_that.priority,_that.status,_that.dueDate,_that.createdBy,_that.assignedTo,_that.proofRequired,_that.proofType,_that.completionRule,_that.attachments,_that.tags,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, @JsonKey(name: 'company_id') required this.companyId, required this.title, this.description, required this.priority, required this.status, @JsonKey(name: 'due_date') this.dueDate, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'assigned_to') required final  List<String> assignedTo, @JsonKey(name: 'proof_required') this.proofRequired = true, @JsonKey(name: 'proof_type') this.proofType = 'text', @JsonKey(name: 'completion_rule') this.completionRule, final  List<String> attachments = const [], final  List<String> tags = const [], @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _assignedTo = assignedTo,_attachments = attachments,_tags = tags,super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override@JsonKey(name: 'company_id') final  String companyId;
@override final  String title;
@override final  String? description;
@override final  String priority;
// 'high', 'medium', 'low'
@override final  String status;
// 'open', 'in_progress', 'completed', 'overdue', 'cancelled'
@override@JsonKey(name: 'due_date') final  DateTime? dueDate;
@override@JsonKey(name: 'created_by') final  String createdBy;
 final  List<String> _assignedTo;
@override@JsonKey(name: 'assigned_to') List<String> get assignedTo {
  if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedTo);
}

@override@JsonKey(name: 'proof_required') final  bool proofRequired;
@override@JsonKey(name: 'proof_type') final  String proofType;
// 'text', 'image', 'pdf', 'url'
@override@JsonKey(name: 'completion_rule') final  String? completionRule;
 final  List<String> _attachments;
@override@JsonKey() List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._assignedTo, _assignedTo)&&(identical(other.proofRequired, proofRequired) || other.proofRequired == proofRequired)&&(identical(other.proofType, proofType) || other.proofType == proofType)&&(identical(other.completionRule, completionRule) || other.completionRule == completionRule)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,title,description,priority,status,dueDate,createdBy,const DeepCollectionEquality().hash(_assignedTo),proofRequired,proofType,completionRule,const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_tags),createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, companyId: $companyId, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, createdBy: $createdBy, assignedTo: $assignedTo, proofRequired: $proofRequired, proofType: $proofType, completionRule: $completionRule, attachments: $attachments, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'company_id') String companyId, String title, String? description, String priority, String status,@JsonKey(name: 'due_date') DateTime? dueDate,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'assigned_to') List<String> assignedTo,@JsonKey(name: 'proof_required') bool proofRequired,@JsonKey(name: 'proof_type') String proofType,@JsonKey(name: 'completion_rule') String? completionRule, List<String> attachments, List<String> tags,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyId = null,Object? title = null,Object? description = freezed,Object? priority = null,Object? status = null,Object? dueDate = freezed,Object? createdBy = null,Object? assignedTo = null,Object? proofRequired = null,Object? proofType = null,Object? completionRule = freezed,Object? attachments = null,Object? tags = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,assignedTo: null == assignedTo ? _self._assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>,proofRequired: null == proofRequired ? _self.proofRequired : proofRequired // ignore: cast_nullable_to_non_nullable
as bool,proofType: null == proofType ? _self.proofType : proofType // ignore: cast_nullable_to_non_nullable
as String,completionRule: freezed == completionRule ? _self.completionRule : completionRule // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
