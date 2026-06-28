// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_replay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meetingReplayHash() => r'8b508df4b157075186db4c4b10dddaacf896bc7f';

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

/// See also [meetingReplay].
@ProviderFor(meetingReplay)
const meetingReplayProvider = MeetingReplayFamily();

/// See also [meetingReplay].
class MeetingReplayFamily extends Family<AsyncValue<ReplayViewModel>> {
  /// See also [meetingReplay].
  const MeetingReplayFamily();

  /// See also [meetingReplay].
  MeetingReplayProvider call(String meetingId) {
    return MeetingReplayProvider(meetingId);
  }

  @override
  MeetingReplayProvider getProviderOverride(
    covariant MeetingReplayProvider provider,
  ) {
    return call(provider.meetingId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'meetingReplayProvider';
}

/// See also [meetingReplay].
class MeetingReplayProvider extends AutoDisposeFutureProvider<ReplayViewModel> {
  /// See also [meetingReplay].
  MeetingReplayProvider(String meetingId)
    : this._internal(
        (ref) => meetingReplay(ref as MeetingReplayRef, meetingId),
        from: meetingReplayProvider,
        name: r'meetingReplayProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$meetingReplayHash,
        dependencies: MeetingReplayFamily._dependencies,
        allTransitiveDependencies:
            MeetingReplayFamily._allTransitiveDependencies,
        meetingId: meetingId,
      );

  MeetingReplayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.meetingId,
  }) : super.internal();

  final String meetingId;

  @override
  Override overrideWith(
    FutureOr<ReplayViewModel> Function(MeetingReplayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MeetingReplayProvider._internal(
        (ref) => create(ref as MeetingReplayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        meetingId: meetingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReplayViewModel> createElement() {
    return _MeetingReplayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MeetingReplayProvider && other.meetingId == meetingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, meetingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MeetingReplayRef on AutoDisposeFutureProviderRef<ReplayViewModel> {
  /// The parameter `meetingId` of this provider.
  String get meetingId;
}

class _MeetingReplayProviderElement
    extends AutoDisposeFutureProviderElement<ReplayViewModel>
    with MeetingReplayRef {
  _MeetingReplayProviderElement(super.provider);

  @override
  String get meetingId => (origin as MeetingReplayProvider).meetingId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
