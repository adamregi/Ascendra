import '../entities/meeting.dart';
import '../entities/meeting_attendance.dart';
import '../entities/meeting_session.dart';

/// Abstract contract for meeting operations.
///
/// Handles scheduling, status transitions, joining/leaving sessions, and history querying.
abstract class MeetingRepository {
  /// Schedule a new meeting.
  ///
  /// Maps to inserting a row in the `meetings` table.
  Future<Meeting> scheduleMeeting({
    required String companyId,
    required String leaderId,
    required String title,
    String? description,
    String? agenda,
    String? meetingUrl,
    String? roomId,
    required DateTime scheduledAt,
    int? durationMinutes,
    bool recordingEnabled,
    bool lateJoinAllowed,
    int? lateJoinCutoffMinutes,
    int? maxParticipants,
    String? meetingCode,
  });

  /// Start a scheduled meeting.
  ///
  /// Calls the database RPC `start_meeting`. Enforces:
  ///   - Only the host leader can start.
  ///   - Only scheduled meetings can be started.
  Future<Meeting> startMeeting({
    required String meetingId,
    required String leaderId,
  });

  /// End a live meeting.
  ///
  /// Calls the database RPC `end_meeting`. Enforces:
  ///   - Only the host leader can end.
  ///   - Only live meetings can be ended.
  Future<Meeting> endMeeting({
    required String meetingId,
    required String leaderId,
  });

  /// Join a live meeting session.
  ///
  /// Calls the database RPC `join_meeting_session`.
  /// Registers attendance on-demand if no record exists, validates late join rules,
  /// validates participant capacity, and returns the active session.
  Future<MeetingSession> joinMeeting({
    required String meetingId,
    required String profileId,
    String joinSource,
  });

  /// Leave a live meeting session.
  ///
  /// Calls the database RPC `leave_meeting_session`.
  /// Closes the active session segment by setting `left_at = now()`.
  Future<void> leaveMeeting({
    required String meetingId,
    required String profileId,
  });

  /// Pre-flight check to verify if a member is allowed to join a meeting.
  ///
  /// Inspects meeting status, participant capacity, and late join cutoff times.
  Future<bool> canJoinMeeting({
    required String meetingId,
    required String profileId,
  });

  /// Get details of a single meeting.
  Future<Meeting?> getMeeting({required String meetingId});

  /// Get details of a single meeting by its human-readable code.
  Future<Meeting?> getMeetingByCode({required String meetingCode});

  /// Get all upcoming/live meetings for a company.
  Future<List<Meeting>> getUpcomingMeetings({required String companyId});

  /// Get meeting history (completed/cancelled) for a company.
  Future<List<Meeting>> getMeetingHistory({required String companyId});

  /// Get attendance record for a specific member in a meeting.
  Future<MeetingAttendance?> getMeetingAttendance({
    required String meetingId,
    required String profileId,
  });

  /// Get all attendance records for a meeting.
  Future<List<MeetingAttendance>> getMeetingAttendances({
    required String meetingId,
  });
}
