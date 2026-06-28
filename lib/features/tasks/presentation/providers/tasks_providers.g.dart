// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'9c043c0063736d77fc0b27ecb30aaead6c1a52a4';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$companyTasksHash() => r'7ee2084fb5210b9aaee231b78a8e835e3c6527e5';

/// See also [companyTasks].
@ProviderFor(companyTasks)
final companyTasksProvider = AutoDisposeFutureProvider<List<Task>>.internal(
  companyTasks,
  name: r'companyTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$companyTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompanyTasksRef = AutoDisposeFutureProviderRef<List<Task>>;
String _$filteredTasksHash() => r'818c24576a475813317be7b2096b60843486de59';

/// See also [filteredTasks].
@ProviderFor(filteredTasks)
final filteredTasksProvider = AutoDisposeFutureProvider<List<Task>>.internal(
  filteredTasks,
  name: r'filteredTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredTasksRef = AutoDisposeFutureProviderRef<List<Task>>;
String _$searchedTasksHash() => r'7ffd46eb25d3bb43d1b23d37fc764f4be25c2947';

/// See also [searchedTasks].
@ProviderFor(searchedTasks)
final searchedTasksProvider = AutoDisposeFutureProvider<List<Task>>.internal(
  searchedTasks,
  name: r'searchedTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchedTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchedTasksRef = AutoDisposeFutureProviderRef<List<Task>>;
String _$taskDashboardSummaryHash() =>
    r'1856abb8909446689309b64bdebff774a2ff0bb0';

/// See also [taskDashboardSummary].
@ProviderFor(taskDashboardSummary)
final taskDashboardSummaryProvider =
    AutoDisposeFutureProvider<TaskDashboardSummary>.internal(
      taskDashboardSummary,
      name: r'taskDashboardSummaryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$taskDashboardSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskDashboardSummaryRef =
    AutoDisposeFutureProviderRef<TaskDashboardSummary>;
String _$taskDetailHash() => r'cfaa9ec37036dc352a786b083ff6979ea0b67b46';

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

/// See also [taskDetail].
@ProviderFor(taskDetail)
const taskDetailProvider = TaskDetailFamily();

/// See also [taskDetail].
class TaskDetailFamily extends Family<AsyncValue<Task?>> {
  /// See also [taskDetail].
  const TaskDetailFamily();

  /// See also [taskDetail].
  TaskDetailProvider call(String taskId) {
    return TaskDetailProvider(taskId);
  }

  @override
  TaskDetailProvider getProviderOverride(
    covariant TaskDetailProvider provider,
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
  String? get name => r'taskDetailProvider';
}

/// See also [taskDetail].
class TaskDetailProvider extends AutoDisposeFutureProvider<Task?> {
  /// See also [taskDetail].
  TaskDetailProvider(String taskId)
    : this._internal(
        (ref) => taskDetail(ref as TaskDetailRef, taskId),
        from: taskDetailProvider,
        name: r'taskDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$taskDetailHash,
        dependencies: TaskDetailFamily._dependencies,
        allTransitiveDependencies: TaskDetailFamily._allTransitiveDependencies,
        taskId: taskId,
      );

  TaskDetailProvider._internal(
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
    FutureOr<Task?> Function(TaskDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskDetailProvider._internal(
        (ref) => create(ref as TaskDetailRef),
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
  AutoDisposeFutureProviderElement<Task?> createElement() {
    return _TaskDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskDetailProvider && other.taskId == taskId;
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
mixin TaskDetailRef on AutoDisposeFutureProviderRef<Task?> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _TaskDetailProviderElement extends AutoDisposeFutureProviderElement<Task?>
    with TaskDetailRef {
  _TaskDetailProviderElement(super.provider);

  @override
  String get taskId => (origin as TaskDetailProvider).taskId;
}

String _$taskAssignmentsHash() => r'f86a9c3868417b7643fdc28a35a888590d609ceb';

/// See also [taskAssignments].
@ProviderFor(taskAssignments)
const taskAssignmentsProvider = TaskAssignmentsFamily();

/// See also [taskAssignments].
class TaskAssignmentsFamily extends Family<AsyncValue<List<TaskAssignment>>> {
  /// See also [taskAssignments].
  const TaskAssignmentsFamily();

  /// See also [taskAssignments].
  TaskAssignmentsProvider call(String taskId) {
    return TaskAssignmentsProvider(taskId);
  }

  @override
  TaskAssignmentsProvider getProviderOverride(
    covariant TaskAssignmentsProvider provider,
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
  String? get name => r'taskAssignmentsProvider';
}

/// See also [taskAssignments].
class TaskAssignmentsProvider
    extends AutoDisposeFutureProvider<List<TaskAssignment>> {
  /// See also [taskAssignments].
  TaskAssignmentsProvider(String taskId)
    : this._internal(
        (ref) => taskAssignments(ref as TaskAssignmentsRef, taskId),
        from: taskAssignmentsProvider,
        name: r'taskAssignmentsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$taskAssignmentsHash,
        dependencies: TaskAssignmentsFamily._dependencies,
        allTransitiveDependencies:
            TaskAssignmentsFamily._allTransitiveDependencies,
        taskId: taskId,
      );

  TaskAssignmentsProvider._internal(
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
    FutureOr<List<TaskAssignment>> Function(TaskAssignmentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskAssignmentsProvider._internal(
        (ref) => create(ref as TaskAssignmentsRef),
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
  AutoDisposeFutureProviderElement<List<TaskAssignment>> createElement() {
    return _TaskAssignmentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskAssignmentsProvider && other.taskId == taskId;
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
mixin TaskAssignmentsRef on AutoDisposeFutureProviderRef<List<TaskAssignment>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _TaskAssignmentsProviderElement
    extends AutoDisposeFutureProviderElement<List<TaskAssignment>>
    with TaskAssignmentsRef {
  _TaskAssignmentsProviderElement(super.provider);

  @override
  String get taskId => (origin as TaskAssignmentsProvider).taskId;
}

String _$taskAssignmentStatsHash() =>
    r'87b737632b6fc0fd852606ea2915b3ce0beefe7c';

/// See also [taskAssignmentStats].
@ProviderFor(taskAssignmentStats)
const taskAssignmentStatsProvider = TaskAssignmentStatsFamily();

/// See also [taskAssignmentStats].
class TaskAssignmentStatsFamily extends Family<AsyncValue<Map<String, int>>> {
  /// See also [taskAssignmentStats].
  const TaskAssignmentStatsFamily();

  /// See also [taskAssignmentStats].
  TaskAssignmentStatsProvider call(String taskId) {
    return TaskAssignmentStatsProvider(taskId);
  }

  @override
  TaskAssignmentStatsProvider getProviderOverride(
    covariant TaskAssignmentStatsProvider provider,
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
  String? get name => r'taskAssignmentStatsProvider';
}

/// See also [taskAssignmentStats].
class TaskAssignmentStatsProvider
    extends AutoDisposeFutureProvider<Map<String, int>> {
  /// See also [taskAssignmentStats].
  TaskAssignmentStatsProvider(String taskId)
    : this._internal(
        (ref) => taskAssignmentStats(ref as TaskAssignmentStatsRef, taskId),
        from: taskAssignmentStatsProvider,
        name: r'taskAssignmentStatsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$taskAssignmentStatsHash,
        dependencies: TaskAssignmentStatsFamily._dependencies,
        allTransitiveDependencies:
            TaskAssignmentStatsFamily._allTransitiveDependencies,
        taskId: taskId,
      );

  TaskAssignmentStatsProvider._internal(
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
    FutureOr<Map<String, int>> Function(TaskAssignmentStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskAssignmentStatsProvider._internal(
        (ref) => create(ref as TaskAssignmentStatsRef),
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
  AutoDisposeFutureProviderElement<Map<String, int>> createElement() {
    return _TaskAssignmentStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskAssignmentStatsProvider && other.taskId == taskId;
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
mixin TaskAssignmentStatsRef on AutoDisposeFutureProviderRef<Map<String, int>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _TaskAssignmentStatsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, int>>
    with TaskAssignmentStatsRef {
  _TaskAssignmentStatsProviderElement(super.provider);

  @override
  String get taskId => (origin as TaskAssignmentStatsProvider).taskId;
}

String _$selectedTaskFilterHash() =>
    r'ba124d15c53adfa6fc1f5fb4a1e3ebdb289c4bed';

/// See also [SelectedTaskFilter].
@ProviderFor(SelectedTaskFilter)
final selectedTaskFilterProvider = AutoDisposeNotifierProvider<
  SelectedTaskFilter,
  TaskDashboardFilter
>.internal(
  SelectedTaskFilter.new,
  name: r'selectedTaskFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedTaskFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedTaskFilter = AutoDisposeNotifier<TaskDashboardFilter>;
String _$taskSearchQueryHash() => r'652367f057aa6562ffe56f78983f410f5f8fc79c';

/// See also [TaskSearchQuery].
@ProviderFor(TaskSearchQuery)
final taskSearchQueryProvider =
    AutoDisposeNotifierProvider<TaskSearchQuery, String>.internal(
      TaskSearchQuery.new,
      name: r'taskSearchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$taskSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TaskSearchQuery = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
