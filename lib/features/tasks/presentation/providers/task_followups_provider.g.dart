// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_followups_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskFollowupsHash() => r'e02c307c9fd42a3d31fb1577330992a57f1949a3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [taskFollowups].
@ProviderFor(taskFollowups)
const taskFollowupsProvider = TaskFollowupsFamily();

/// See also [taskFollowups].
class TaskFollowupsFamily extends Family<AsyncValue<List<FollowUp>>> {
  /// See also [taskFollowups].
  const TaskFollowupsFamily();

  /// See also [taskFollowups].
  TaskFollowupsProvider call(String taskId) {
    return TaskFollowupsProvider(taskId);
  }

  @override
  TaskFollowupsProvider getProviderOverride(
    covariant TaskFollowupsProvider provider,
  ) {
    return call(provider.taskId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskFollowupsProvider';
}

/// See also [taskFollowups].
class TaskFollowupsProvider extends AutoDisposeFutureProvider<List<FollowUp>> {
  /// See also [taskFollowups].
  TaskFollowupsProvider(String taskId)
    : this._internal(
        (ref) => taskFollowups(ref as TaskFollowupsRef, taskId),
        from: taskFollowupsProvider,
        name: r'taskFollowupsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$taskFollowupsHash,
        dependencies: TaskFollowupsFamily._dependencies,
        allTransitiveDependencies:
            TaskFollowupsFamily._allTransitiveDependencies,
        taskId: taskId,
      );

  TaskFollowupsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  Override overrideWith(
    FutureOr<List<FollowUp>> Function(TaskFollowupsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskFollowupsProvider._internal(
        (ref) => create(ref as TaskFollowupsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FollowUp>> createElement() {
    return _TaskFollowupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskFollowupsProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskFollowupsRef on AutoDisposeFutureProviderRef<List<FollowUp>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _TaskFollowupsProviderElement
    extends AutoDisposeFutureProviderElement<List<FollowUp>>
    with TaskFollowupsRef {
  _TaskFollowupsProviderElement(super.provider);

  @override
  String get taskId => (origin as TaskFollowupsProvider).taskId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
