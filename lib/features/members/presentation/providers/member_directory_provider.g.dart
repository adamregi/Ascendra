// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_directory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memberRepositoryHash() => r'c8b460b61eb96b2b1f7612a1f6c82c9173f7420a';

/// See also [memberRepository].
@ProviderFor(memberRepository)
final memberRepositoryProvider = AutoDisposeProvider<MemberRepository>.internal(
  memberRepository,
  name: r'memberRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$memberRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MemberRepositoryRef = AutoDisposeProviderRef<MemberRepository>;
String _$memberDirectoryHash() => r'c2dfe5266ed89d1715f6a71403bb21fe545a3b7d';

/// See also [memberDirectory].
@ProviderFor(memberDirectory)
final memberDirectoryProvider =
    AutoDisposeFutureProvider<List<MemberDirectoryItem>>.internal(
      memberDirectory,
      name: r'memberDirectoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberDirectoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MemberDirectoryRef =
    AutoDisposeFutureProviderRef<List<MemberDirectoryItem>>;
String _$memberSearchQueryHash() => r'3019f7daa4d9558a7e2ea5a292a543851d604b0d';

/// See also [MemberSearchQuery].
@ProviderFor(MemberSearchQuery)
final memberSearchQueryProvider =
    AutoDisposeNotifierProvider<MemberSearchQuery, String>.internal(
      MemberSearchQuery.new,
      name: r'memberSearchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemberSearchQuery = AutoDisposeNotifier<String>;
String _$memberStatusFilterHash() =>
    r'55f489ba17160f929d5530ce2dc1c5b1cb4eb410';

/// See also [MemberStatusFilter].
@ProviderFor(MemberStatusFilter)
final memberStatusFilterProvider =
    AutoDisposeNotifierProvider<MemberStatusFilter, String?>.internal(
      MemberStatusFilter.new,
      name: r'memberStatusFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberStatusFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemberStatusFilter = AutoDisposeNotifier<String?>;
String _$memberPromotionReadyFilterHash() =>
    r'c3d82994580337731135c6b06ce10982deb650da';

/// See also [MemberPromotionReadyFilter].
@ProviderFor(MemberPromotionReadyFilter)
final memberPromotionReadyFilterProvider =
    AutoDisposeNotifierProvider<MemberPromotionReadyFilter, bool?>.internal(
      MemberPromotionReadyFilter.new,
      name: r'memberPromotionReadyFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberPromotionReadyFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemberPromotionReadyFilter = AutoDisposeNotifier<bool?>;
String _$memberHighRiskFilterHash() =>
    r'78499bee27413320181eb49267fd8f5516fc368b';

/// See also [MemberHighRiskFilter].
@ProviderFor(MemberHighRiskFilter)
final memberHighRiskFilterProvider =
    AutoDisposeNotifierProvider<MemberHighRiskFilter, bool?>.internal(
      MemberHighRiskFilter.new,
      name: r'memberHighRiskFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$memberHighRiskFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemberHighRiskFilter = AutoDisposeNotifier<bool?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
