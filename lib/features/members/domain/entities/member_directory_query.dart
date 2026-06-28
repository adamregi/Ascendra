import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_directory_query.freezed.dart';

@freezed
abstract class MemberDirectoryFilter with _$MemberDirectoryFilter {
  const factory MemberDirectoryFilter({
    String? searchQuery,
    String? status,
    String? leaderId,
    bool? promotionReady,
    bool? highRisk,
  }) = _MemberDirectoryFilter;
}

@freezed
abstract class MemberDirectoryQueryParams with _$MemberDirectoryQueryParams {
  const factory MemberDirectoryQueryParams({
    required MemberDirectoryFilter filter,
    String? cursor,
    @Default(50) int limit,
  }) = _MemberDirectoryQueryParams;
}
