import '../../domain/entities/member_profile.dart';
import '../dto/rpc/v1/member_profile_rpc_dto.dart';

class MemberProfileMapper {
  MemberProfile mapDtoToEntity(MemberProfileRpcDto dto) {
    return MemberProfile(
      hero: _mapHero(dto.hero),
      overview: _mapOverview(dto.overview),
      compliance: _mapCompliance(dto.compliance),
      timeline: dto.timeline.map(_mapTimeline).toList(),
      recognition: dto.recognition.map(_mapRecognition).toList(),
      analytics: _mapAnalytics(dto.analytics),
    );
  }

  MemberProfileHero _mapHero(MemberProfileHeroDto dto) {
    return MemberProfileHero(
      avatarUrl: dto.avatarUrl,
      firstName: dto.firstName,
      lastName: dto.lastName,
      distributorId: dto.distributorId,
      leaderName: dto.leaderName,
      rank: dto.rank,
      status: dto.status,
      joinedDate: dto.joinedDate,
      currentStreak: dto.currentStreak,
    );
  }

  MemberProfileOverview _mapOverview(MemberProfileOverviewDto dto) {
    return MemberProfileOverview(
      leadershipScore: dto.leadershipScore,
      recognitionCount: dto.recognitionCount,
      complianceScore: dto.complianceScore,
      meetingPercent: dto.meetingPercent,
      taskPercent: dto.taskPercent,
      riskLevel: dto.riskLevel,
    );
  }

  MemberProfileCompliance _mapCompliance(MemberProfileComplianceDto dto) {
    return MemberProfileCompliance(
      score: dto.score,
      reasons: dto.reasons,
      nextImprovement: dto.nextImprovement,
    );
  }

  MemberTimelineEvent _mapTimeline(MemberProfileTimelineDto dto) {
    return MemberTimelineEvent(
      type: _mapTimelineType(dto.type),
      timestamp: dto.timestamp,
      title: dto.title,
      description: dto.description,
    );
  }

  TimelineEventType _mapTimelineType(String type) {
    switch (type.toLowerCase()) {
      case 'meeting':
        return TimelineEventType.meeting;
      case 'task':
        return TimelineEventType.task;
      case 'proof':
        return TimelineEventType.proof;
      case 'followup':
        return TimelineEventType.followup;
      case 'recognition':
        return TimelineEventType.recognition;
      case 'promotion':
        return TimelineEventType.promotion;
      case 'warning':
        return TimelineEventType.warning;
      case 'suspension':
        return TimelineEventType.suspension;
      case 'termination':
        return TimelineEventType.termination;
      case 'note':
        return TimelineEventType.note;
      default:
        return TimelineEventType.unknown;
    }
  }

  MemberRecognition _mapRecognition(MemberProfileRecognitionDto dto) {
    return MemberRecognition(
      name: dto.name,
      description: dto.description,
      earnedDate: dto.earnedDate,
      category: dto.category,
      icon: dto.icon,
      level: dto.level,
      points: dto.points,
    );
  }

  MemberAnalytics _mapAnalytics(MemberProfileAnalyticsDto dto) {
    return MemberAnalytics(
      leadershipTrend: dto.leadershipTrend,
      attendanceTrend: dto.attendanceTrend,
      taskTrend: dto.taskTrend,
    );
  }
}
