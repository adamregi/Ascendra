import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../profile/data/user_repository.dart';
import '../../../../shared/models/member_profile.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_attendance.dart';
import 'meetings_providers.dart';

part 'meeting_replay_provider.g.dart';

class ReplayViewModel {
  final Meeting meeting;
  final List<AttendanceWithProfile> attendances;

  const ReplayViewModel({
    required this.meeting,
    required this.attendances,
  });
}

class AttendanceWithProfile {
  final MeetingAttendance attendance;
  final String fullName;
  final String? email;
  final String? distributorId;

  const AttendanceWithProfile({
    required this.attendance,
    required this.fullName,
    this.email,
    this.distributorId,
  });
}

@riverpod
Future<ReplayViewModel> meetingReplay(Ref ref, String meetingId) async {
  final meetingRepo = ref.watch(meetingRepositoryProvider);
  final userRepo = ref.watch(userRepositoryProvider);

  // 1. Fetch meeting
  final meeting = await meetingRepo.getMeeting(meetingId: meetingId);
  if (meeting == null) {
    throw Exception('Meeting not found');
  }

  // 2. Fetch attendances
  final attendances = await meetingRepo.getMeetingAttendances(meetingId: meetingId);

  // 3. Fetch profiles for all attendees
  final profileIds = attendances.map((a) => a.profileId).toList();
  final profiles = profileIds.isNotEmpty 
      ? await userRepo.getProfilesByIds(profileIds) 
      : <MemberProfile>[];

  // Map to AttendanceWithProfile
  final enriched = attendances.map((a) {
    final profile = profiles.firstWhere(
      (p) => p.id == a.profileId,
      orElse: () => MemberProfile(
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

  return ReplayViewModel(
    meeting: meeting,
    attendances: enriched,
  );
}
