import '../../domain/repositories/meeting_repository.dart';
import '../../domain/repositories/meeting_replay_repository.dart';
import '../../domain/entities/replay_view_model.dart';
import '../../../profile/data/user_repository.dart';
import '../../../../shared/models/member_profile.dart';

class MeetingReplayRepositoryImpl implements MeetingReplayRepository {
  final MeetingRepository _meetingRepository;
  final UserRepository _userRepository;

  MeetingReplayRepositoryImpl({
    required MeetingRepository meetingRepository,
    required UserRepository userRepository,
  }) : _meetingRepository = meetingRepository,
       _userRepository = userRepository;

  @override
  Future<ReplayViewModel> getMeetingReplayData(String meetingId) async {
    // 1. Fetch meeting
    final meeting = await _meetingRepository.getMeeting(meetingId: meetingId);
    if (meeting == null) {
      throw Exception('Meeting not found');
    }

    // 2. Fetch attendances
    final attendances = await _meetingRepository.getMeetingAttendances(
      meetingId: meetingId,
    );

    // 3. Fetch profiles for all attendees
    final profileIds = attendances.map((a) => a.profileId).toList();
    final profiles =
        profileIds.isNotEmpty
            ? await _userRepository.getProfilesByIds(profileIds)
            : <MemberProfile>[];

    // Map to AttendanceWithProfile
    final enriched =
        attendances.map((a) {
          final profile = profiles.firstWhere(
            (p) => p.id == a.profileId,
            orElse:
                () => MemberProfile(
                  id: a.profileId,
                  companyId: meeting.companyId,
                  fullName: 'Unknown Member',
                  role: 'member',
                  status: 'active',
                ),
          );

          return AttendanceWithProfile(
            attendance: a,
            fullName: profile.fullName,
            email: profile.email,
            distributorId: profile.distributorId,
          );
        }).toList();

    return ReplayViewModel(meeting: meeting, attendances: enriched);
  }
}
