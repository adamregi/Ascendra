import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_attendance.dart';
import '../../domain/entities/meeting_session.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../models/meeting_model.dart';
import '../models/meeting_attendance_model.dart';
import '../models/meeting_session_model.dart';

class MeetingRepositoryImpl extends BaseRepository implements MeetingRepository {
  final supabase.SupabaseClient _client;

  MeetingRepositoryImpl(this._client);

  @override
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
    bool recordingEnabled = false,
    bool lateJoinAllowed = true,
    int? lateJoinCutoffMinutes,
    int? maxParticipants,
    String? meetingCode,
  }) async {
    try {
      final insertData = {
        'company_id': companyId,
        'leader_id': leaderId,
        'title': title,
        'description': description,
        'agenda': agenda,
        'meeting_url': meetingUrl,
        'room_id': roomId,
        'scheduled_at': scheduledAt.toIso8601String(),
        'duration_minutes': durationMinutes,
        'recording_enabled': recordingEnabled,
        'late_join_allowed': lateJoinAllowed,
        'late_join_cutoff_minutes': lateJoinCutoffMinutes,
        'max_participants': maxParticipants,
      };
      if (meetingCode != null) {
        insertData['meeting_code'] = meetingCode;
      }

      final response = await _client.from('meetings').insert(insertData).select().single();

      return MeetingModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Meeting> startMeeting({
    required String meetingId,
    required String leaderId,
  }) async {
    try {
      final data = await _client.rpc('start_meeting', params: {
        'p_meeting_id': meetingId,
        'p_leader_id': leaderId,
      });
      return MeetingModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Meeting> endMeeting({
    required String meetingId,
    required String leaderId,
  }) async {
    try {
      final data = await _client.rpc('end_meeting', params: {
        'p_meeting_id': meetingId,
        'p_leader_id': leaderId,
      });
      return MeetingModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<MeetingSession> joinMeeting({
    required String meetingId,
    required String profileId,
    String joinSource = 'mobile',
  }) async {
    try {
      final data = await _client.rpc('join_meeting_session', params: {
        'p_meeting_id': meetingId,
        'p_profile_id': profileId,
        'p_join_source': joinSource,
      });
      return MeetingSessionModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> leaveMeeting({
    required String meetingId,
    required String profileId,
  }) async {
    try {
      await _client.rpc('leave_meeting_session', params: {
        'p_meeting_id': meetingId,
        'p_profile_id': profileId,
      });
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<bool> canJoinMeeting({
    required String meetingId,
    required String profileId,
  }) async {
    try {
      final meeting = await getMeeting(meetingId: meetingId);
      if (meeting == null || !meeting.isLive) {
        return false;
      }

      // Check capacity
      if (meeting.maxParticipants != null) {
        final List<dynamic> activeRes = await _client.from('meeting_sessions')
            .select('id, meeting_attendances!inner(meeting_id)')
            .eq('meeting_attendances.meeting_id', meetingId)
            .isFilter('left_at', null);

        final activeCount = activeRes.length;
        if (activeCount >= meeting.maxParticipants!) {
          return false;
        }
      }

      // Check late join
      final attendance = await getMeetingAttendance(meetingId: meetingId, profileId: profileId);
      bool hasSessions = false;
      if (attendance != null) {
        final List<dynamic> sessionsCount = await _client.from('meeting_sessions')
            .select('id')
            .eq('attendance_id', attendance.id);

        hasSessions = sessionsCount.isNotEmpty;
      }

      if (!hasSessions && !meeting.lateJoinAllowed) {
        if (meeting.startedAt != null) {
          final difference = DateTime.now().difference(meeting.startedAt!).inMinutes;
          if (difference > (meeting.lateJoinCutoffMinutes ?? 0)) {
            return false;
          }
        }
      }

      return true;
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Meeting?> getMeeting({required String meetingId}) async {
    try {
      final data = await _client
          .from('meetings')
          .select()
          .eq('id', meetingId)
          .maybeSingle();

      if (data == null) return null;
      return MeetingModel.fromJson(data);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Meeting?> getMeetingByCode({required String meetingCode}) async {
    try {
      final data = await _client
          .from('meetings')
          .select()
          .eq('meeting_code', meetingCode)
          .maybeSingle();

      if (data == null) return null;
      return MeetingModel.fromJson(data);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Meeting>> getUpcomingMeetings({required String companyId}) async {
    try {
      final List<dynamic> data = await _client
          .from('meetings')
          .select()
          .eq('company_id', companyId)
          .inFilter('meeting_status', ['scheduled', 'live'])
          .order('scheduled_at', ascending: true);

      return data.map((e) => MeetingModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Meeting>> getMeetingHistory({required String companyId}) async {
    try {
      final List<dynamic> data = await _client
          .from('meetings')
          .select()
          .eq('company_id', companyId)
          .inFilter('meeting_status', ['completed', 'cancelled'])
          .order('scheduled_at', ascending: false);

      return data.map((e) => MeetingModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<MeetingAttendance?> getMeetingAttendance({
    required String meetingId,
    required String profileId,
  }) async {
    try {
      final data = await _client
          .from('meeting_attendances')
          .select()
          .eq('meeting_id', meetingId)
          .eq('profile_id', profileId)
          .maybeSingle();

      if (data == null) return null;
      return MeetingAttendanceModel.fromJson(data);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<MeetingAttendance>> getMeetingAttendances({
    required String meetingId,
  }) async {
    try {
      final List<dynamic> data = await _client
          .from('meeting_attendances')
          .select()
          .eq('meeting_id', meetingId);

      return data.map((e) => MeetingAttendanceModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
