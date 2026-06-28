import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_timeline_event_model.freezed.dart';
part 'member_timeline_event_model.g.dart';

@freezed
abstract class MemberTimelineEventModel with _$MemberTimelineEventModel {
  const factory MemberTimelineEventModel({
    required String type,
    required DateTime timestamp,
    required String title,
    required String description,
  }) = _MemberTimelineEventModel;

  factory MemberTimelineEventModel.fromJson(Map<String, dynamic> json) =>
      _$MemberTimelineEventModelFromJson(json);
}
