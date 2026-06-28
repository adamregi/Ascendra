import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import '../../domain/repositories/live_meeting_repository.dart';

class LiveMeetingRepositoryImpl implements LiveMeetingRepository {
  final SupabaseClient _supabaseClient;
  final HMSSDK _hmsSdk = HMSSDK();

  String? _activeMeetingId;
  String? _activeProfileId;

  LiveMeetingRepositoryImpl(this._supabaseClient);

  @override
  Future<void> joinMeeting({
    required String meetingId,
    required String userName,
  }) async {
    try {
      // 1. Fetch token from Edge Function
      final response = await _supabaseClient.functions.invoke(
        'get-meeting-token',
        body: {'meetingId': meetingId},
      );

      if (response.status != 200) {
        throw Exception('Failed to fetch meeting token: ${response.data}');
      }

      final token = response.data['token'] as String;

      // 2. Build HMSSDK and join the room
      await _hmsSdk.build();
      final config = HMSConfig(authToken: token, userName: userName);
      await _hmsSdk.join(config: config);

      // Store active state
      _activeMeetingId = meetingId;

      // Resolve user profile ID from auth_user_id
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser != null) {
        final profileResponse =
            await _supabaseClient
                .from('profiles')
                .select('id')
                .eq('auth_user_id', currentUser.id)
                .single();
        _activeProfileId = profileResponse['id'] as String;

        // 3. Register attendance on database
        await _supabaseClient.rpc(
          'join_meeting_session',
          params: {
            'p_meeting_id': meetingId,
            'p_profile_id': _activeProfileId,
            'p_join_source': 'mobile',
          },
        );
      }
    } catch (e) {
      // Cleanup on failure
      _activeMeetingId = null;
      _activeProfileId = null;
      rethrow;
    }
  }

  @override
  Future<void> leaveMeeting() async {
    try {
      // 1. Leave the 100ms room
      _hmsSdk.leave();

      // 2. Register leave in DB
      if (_activeMeetingId != null && _activeProfileId != null) {
        await _supabaseClient.rpc(
          'leave_meeting_session',
          params: {
            'p_meeting_id': _activeMeetingId,
            'p_profile_id': _activeProfileId,
          },
        );
      }
    } finally {
      // Clear active state regardless of database operation outcome
      _activeMeetingId = null;
      _activeProfileId = null;
    }
  }

  @override
  Future<void> toggleMic() async {
    await _hmsSdk.toggleMicMuteState();
  }

  @override
  Future<void> toggleCamera() async {
    await _hmsSdk.toggleCameraMuteState();
  }

  @override
  void addUpdateListener(HMSUpdateListener listener) {
    _hmsSdk.addUpdateListener(listener: listener);
  }

  @override
  void removeUpdateListener(HMSUpdateListener listener) {
    _hmsSdk.removeUpdateListener(listener: listener);
  }

  @override
  Future<List<HMSAudioDevice>> getAudioDevices() async {
    return await _hmsSdk.getAudioDevicesList();
  }

  @override
  Future<void> switchAudioOutput(HMSAudioDevice device) async {
    _hmsSdk.switchAudioOutput(audioDevice: device);
  }
}
