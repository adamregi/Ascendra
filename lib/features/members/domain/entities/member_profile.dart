import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_profile.freezed.dart';

@freezed
abstract class MemberProfile with _$MemberProfile {
  const factory MemberProfile({
    required MemberProfileHero hero,
    required MemberProfileOverview overview,
    required MemberProfileCompliance compliance,
    required List<MemberTimelineEvent> timeline,
    required List<MemberRecognition> recognition,
    required MemberAnalytics analytics,
  }) = _MemberProfile;
}

@freezed
abstract class MemberProfileHero with _$MemberProfileHero {
  const factory MemberProfileHero({
    String? avatarUrl,
    required String firstName,
    required String lastName,
    required String distributorId,
    String? leaderName,
    required String rank,
    required String status,
    required DateTime joinedDate,
    required int currentStreak,
  }) = _MemberProfileHero;
}

@freezed
abstract class MemberProfileOverview with _$MemberProfileOverview {
  const factory MemberProfileOverview({
    required int leadershipScore,
    required int recognitionCount,
    required int complianceScore,
    required double meetingPercent,
    required double taskPercent,
    required String riskLevel,
  }) = _MemberProfileOverview;
}

@freezed
abstract class MemberProfileCompliance with _$MemberProfileCompliance {
  const factory MemberProfileCompliance({
    required int score,
    required List<String> reasons,
    required String nextImprovement,
  }) = _MemberProfileCompliance;
}

enum TimelineEventType {
  meeting,
  task,
  proof,
  followup,
  recognition,
  promotion,
  warning,
  suspension,
  termination,
  note,
  unknown,
}

@freezed
abstract class MemberTimelineEvent with _$MemberTimelineEvent {
  const factory MemberTimelineEvent({
    required TimelineEventType type,
    required DateTime timestamp,
    required String title,
    required String description,
  }) = _MemberTimelineEvent;
}

@freezed
abstract class MemberRecognition with _$MemberRecognition {
  const factory MemberRecognition({
    required String name,
    required String description,
    required DateTime earnedDate,
    required String category,
    required String icon,
    required int level,
    required int points,
  }) = _MemberRecognition;
}

@freezed
abstract class MemberAnalytics with _$MemberAnalytics {
  const factory MemberAnalytics({
    required List<int> leadershipTrend,
    required List<int> attendanceTrend,
    required List<int> taskTrend,
  }) = _MemberAnalytics;
}
