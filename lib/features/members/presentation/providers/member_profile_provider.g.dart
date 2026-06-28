// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memberProfileRepositoryHash() =>
    r'ab3d8bf341e73c21a62a77f2b7cccb7b4db8dae4';

/// See also [memberProfileRepository].
@ProviderFor(memberProfileRepository)
final memberProfileRepositoryProvider =
    AutoDisposeProvider<MemberProfileRepository>.internal(
      memberProfileRepository,
      name: r'memberProfileRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberProfileRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MemberProfileRepositoryRef =
    AutoDisposeProviderRef<MemberProfileRepository>;
String _$memberProfileHash() => r'2491ce6bb4818f9d77b514be41d3080b7b9f51c5';

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

/// See also [memberProfile].
@ProviderFor(memberProfile)
const memberProfileProvider = MemberProfileFamily();

/// See also [memberProfile].
class MemberProfileFamily extends Family<AsyncValue<MemberProfileViewModel>> {
  /// See also [memberProfile].
  const MemberProfileFamily();

  /// See also [memberProfile].
  MemberProfileProvider call(String profileId) {
    return MemberProfileProvider(profileId);
  }

  @override
  MemberProfileProvider getProviderOverride(
    covariant MemberProfileProvider provider,
  ) {
    return call(provider.profileId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'memberProfileProvider';
}

/// See also [memberProfile].
class MemberProfileProvider
    extends AutoDisposeFutureProvider<MemberProfileViewModel> {
  /// See also [memberProfile].
  MemberProfileProvider(String profileId)
    : this._internal(
        (ref) => memberProfile(ref as MemberProfileRef, profileId),
        from: memberProfileProvider,
        name: r'memberProfileProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$memberProfileHash,
        dependencies: MemberProfileFamily._dependencies,
        allTransitiveDependencies:
            MemberProfileFamily._allTransitiveDependencies,
        profileId: profileId,
      );

  MemberProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profileId,
  }) : super.internal();

  final String profileId;

  @override
  Override overrideWith(
    FutureOr<MemberProfileViewModel> Function(MemberProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MemberProfileProvider._internal(
        (ref) => create(ref as MemberProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profileId: profileId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MemberProfileViewModel> createElement() {
    return _MemberProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberProfileProvider && other.profileId == profileId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profileId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MemberProfileRef on AutoDisposeFutureProviderRef<MemberProfileViewModel> {
  /// The parameter `profileId` of this provider.
  String get profileId;
}

class _MemberProfileProviderElement
    extends AutoDisposeFutureProviderElement<MemberProfileViewModel>
    with MemberProfileRef {
  _MemberProfileProviderElement(super.provider);

  @override
  String get profileId => (origin as MemberProfileProvider).profileId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
