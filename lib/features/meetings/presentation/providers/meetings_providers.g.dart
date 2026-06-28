// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meetingRepositoryHash() => r'd285ff8728d3d6f96daceef9ca4eadafb989a834';

/// See also [meetingRepository].
@ProviderFor(meetingRepository)
final meetingRepositoryProvider =
    AutoDisposeProvider<MeetingRepository>.internal(
      meetingRepository,
      name: r'meetingRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$meetingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MeetingRepositoryRef = AutoDisposeProviderRef<MeetingRepository>;
String _$upcomingMeetingsHash() => r'dfbec2c0162f0e6ef3673ebf9696e2b5e4e7fc36';

/// See also [upcomingMeetings].
@ProviderFor(upcomingMeetings)
final upcomingMeetingsProvider =
    AutoDisposeFutureProvider<List<Meeting>>.internal(
      upcomingMeetings,
      name: r'upcomingMeetingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$upcomingMeetingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingMeetingsRef = AutoDisposeFutureProviderRef<List<Meeting>>;
String _$meetingHistoryHash() => r'a13dc0700397c3b5b6eeab3add61a29309a27f73';

/// See also [meetingHistory].
@ProviderFor(meetingHistory)
final meetingHistoryProvider =
    AutoDisposeFutureProvider<List<Meeting>>.internal(
      meetingHistory,
      name: r'meetingHistoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$meetingHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MeetingHistoryRef = AutoDisposeFutureProviderRef<List<Meeting>>;
String _$meetingDashboardSummaryHash() =>
    r'73e60ddfd5404109eceff7b9c4d9562f787941a2';

/// See also [meetingDashboardSummary].
@ProviderFor(meetingDashboardSummary)
final meetingDashboardSummaryProvider =
    AutoDisposeFutureProvider<MeetingDashboardSummary>.internal(
      meetingDashboardSummary,
      name: r'meetingDashboardSummaryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$meetingDashboardSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MeetingDashboardSummaryRef =
    AutoDisposeFutureProviderRef<MeetingDashboardSummary>;
String _$filteredMeetingsHash() => r'895ad7c6591eef6ecf2a208b450619709606a673';

/// See also [filteredMeetings].
@ProviderFor(filteredMeetings)
final filteredMeetingsProvider =
    AutoDisposeFutureProvider<List<Meeting>>.internal(
      filteredMeetings,
      name: r'filteredMeetingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$filteredMeetingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredMeetingsRef = AutoDisposeFutureProviderRef<List<Meeting>>;
String _$searchedMeetingsHash() => r'f25d8846705791eeb5b33b4ced4d715c444b93df';

/// See also [searchedMeetings].
@ProviderFor(searchedMeetings)
final searchedMeetingsProvider =
    AutoDisposeFutureProvider<List<Meeting>>.internal(
      searchedMeetings,
      name: r'searchedMeetingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$searchedMeetingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchedMeetingsRef = AutoDisposeFutureProviderRef<List<Meeting>>;
String _$selectedMeetingFilterHash() =>
    r'03cf3464957233bed1b75967bc57f3b326d88af9';

/// See also [SelectedMeetingFilter].
@ProviderFor(SelectedMeetingFilter)
final selectedMeetingFilterProvider = AutoDisposeNotifierProvider<
  SelectedMeetingFilter,
  MeetingStatusFilter
>.internal(
  SelectedMeetingFilter.new,
  name: r'selectedMeetingFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedMeetingFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMeetingFilter = AutoDisposeNotifier<MeetingStatusFilter>;
String _$meetingSearchQueryHash() =>
    r'e32d4a7183e47a106bb68cbfb22177b983d66608';

/// See also [MeetingSearchQuery].
@ProviderFor(MeetingSearchQuery)
final meetingSearchQueryProvider =
    AutoDisposeNotifierProvider<MeetingSearchQuery, String>.internal(
      MeetingSearchQuery.new,
      name: r'meetingSearchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$meetingSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MeetingSearchQuery = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
