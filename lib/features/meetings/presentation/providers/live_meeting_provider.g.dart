// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_meeting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$liveMeetingRepositoryHash() =>
    r'e641624d916a823d4bd35d2518b67cb6c8767e80';

/// See also [liveMeetingRepository].
@ProviderFor(liveMeetingRepository)
final liveMeetingRepositoryProvider =
    AutoDisposeProvider<LiveMeetingRepository>.internal(
      liveMeetingRepository,
      name: r'liveMeetingRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$liveMeetingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LiveMeetingRepositoryRef =
    AutoDisposeProviderRef<LiveMeetingRepository>;
String _$liveMeetingControllerHash() =>
    r'5a7d4399e6ebf4e4b444a9c3f4d8d0252d4cfa7a';

/// See also [LiveMeetingController].
@ProviderFor(LiveMeetingController)
final liveMeetingControllerProvider = AutoDisposeNotifierProvider<
  LiveMeetingController,
  LiveMeetingState
>.internal(
  LiveMeetingController.new,
  name: r'liveMeetingControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$liveMeetingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LiveMeetingController = AutoDisposeNotifier<LiveMeetingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
