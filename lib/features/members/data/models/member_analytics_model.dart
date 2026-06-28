import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_analytics_model.freezed.dart';
part 'member_analytics_model.g.dart';

@freezed
abstract class MemberAnalyticsModel with _$MemberAnalyticsModel {
  const factory MemberAnalyticsModel({
    @JsonKey(name: 'leadership_trend') required List<int> leadershipTrend,
    @JsonKey(name: 'attendance_trend') required List<int> attendanceTrend,
    @JsonKey(name: 'task_trend') required List<int> taskTrend,
  }) = _MemberAnalyticsModel;

  factory MemberAnalyticsModel.fromJson(Map<String, dynamic> json) =>
      _$MemberAnalyticsModelFromJson(json);
}
