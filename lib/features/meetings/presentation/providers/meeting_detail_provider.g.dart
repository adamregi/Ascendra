// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meetingDetailHash() => r'9b78dac2972f8a0d99a41962ff9f5dd76a502be4';

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

/// See also [meetingDetail].
@ProviderFor(meetingDetail)
const meetingDetailProvider = MeetingDetailFamily();

/// See also [meetingDetail].
class MeetingDetailFamily extends Family<AsyncValue<MeetingDetailViewModel>> {
  /// See also [meetingDetail].
  const MeetingDetailFamily();

  /// See also [meetingDetail].
  MeetingDetailProvider call(String meetingId) {
    return MeetingDetailProvider(meetingId);
  }

  @override
  MeetingDetailProvider getProviderOverride(
    covariant MeetingDetailProvider provider,
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
  String? get name => r'meetingDetailProvider';
}

/// See also [meetingDetail].
class MeetingDetailProvider
    extends AutoDisposeFutureProvider<MeetingDetailViewModel> {
  /// See also [meetingDetail].
  MeetingDetailProvider(String meetingId)
    : this._internal(
        (ref) => meetingDetail(ref as MeetingDetailRef, meetingId),
        from: meetingDetailProvider,
        name: r'meetingDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$meetingDetailHash,
        dependencies: MeetingDetailFamily._dependencies,
        allTransitiveDependencies:
            MeetingDetailFamily._allTransitiveDependencies,
        meetingId: meetingId,
      );

  MeetingDetailProvider._internal(
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
    FutureOr<MeetingDetailViewModel> Function(MeetingDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MeetingDetailProvider._internal(
        (ref) => create(ref as MeetingDetailRef),
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
  AutoDisposeFutureProviderElement<MeetingDetailViewModel> createElement() {
    return _MeetingDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MeetingDetailProvider && other.meetingId == meetingId;
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
mixin MeetingDetailRef on AutoDisposeFutureProviderRef<MeetingDetailViewModel> {
  /// The parameter `meetingId` of this provider.
  String get meetingId;
}

class _MeetingDetailProviderElement
    extends AutoDisposeFutureProviderElement<MeetingDetailViewModel>
    with MeetingDetailRef {
  _MeetingDetailProviderElement(super.provider);

  @override
  String get meetingId => (origin as MeetingDetailProvider).meetingId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
