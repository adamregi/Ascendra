import 'meeting.dart';
import 'meeting_attendance.dart';

class ReplayViewModel {
  final Meeting meeting;
  final List<AttendanceWithProfile> attendances;

  const ReplayViewModel({required this.meeting, required this.attendances});
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
