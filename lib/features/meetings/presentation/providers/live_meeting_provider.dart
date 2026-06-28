import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import '../../domain/repositories/live_meeting_repository.dart';
import '../../data/repositories/live_meeting_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'live_meeting_provider.g.dart';

enum LiveMeetingStatus {
  idle,
  joining,
  connected,
  reconnecting,
  disconnected,
  error,
}

class LiveMeetingState {
  final LiveMeetingStatus status;
  final HMSLocalPeer? localPeer;
  final List<HMSPeer> remotePeers;
  final bool isMicMuted;
  final bool isCameraMuted;
  final bool isSpeakerPhoneOn;
  final String? errorMessage;
  final HMSAudioDevice? activeAudioDevice;
  final List<HMSAudioDevice> availableAudioDevices;

  const LiveMeetingState({
    required this.status,
    this.localPeer,
    this.remotePeers = const [],
    this.isMicMuted = true,
    this.isCameraMuted = true,
    this.isSpeakerPhoneOn = false,
    this.errorMessage,
    this.activeAudioDevice,
    this.availableAudioDevices = const [],
  });

  LiveMeetingState copyWith({
    LiveMeetingStatus? status,
    HMSLocalPeer? localPeer,
    List<HMSPeer>? remotePeers,
    bool? isMicMuted,
    bool? isCameraMuted,
    bool? isSpeakerPhoneOn,
    String? errorMessage,
    HMSAudioDevice? activeAudioDevice,
    List<HMSAudioDevice>? availableAudioDevices,
  }) {
    return LiveMeetingState(
      status: status ?? this.status,
      localPeer: localPeer ?? this.localPeer,
      remotePeers: remotePeers ?? this.remotePeers,
      isMicMuted: isMicMuted ?? this.isMicMuted,
      isCameraMuted: isCameraMuted ?? this.isCameraMuted,
      isSpeakerPhoneOn: isSpeakerPhoneOn ?? this.isSpeakerPhoneOn,
      errorMessage: errorMessage ?? this.errorMessage,
      activeAudioDevice: activeAudioDevice ?? this.activeAudioDevice,
      availableAudioDevices:
          availableAudioDevices ?? this.availableAudioDevices,
    );
  }
}

@riverpod
LiveMeetingRepository liveMeetingRepository(Ref ref) {
  return LiveMeetingRepositoryImpl(supabase.Supabase.instance.client);
}

@riverpod
class LiveMeetingController extends _$LiveMeetingController
    implements HMSUpdateListener {
  late final LiveMeetingRepository _repository;

  @override
  LiveMeetingState build() {
    _repository = ref.watch(liveMeetingRepositoryProvider);
    _repository.addUpdateListener(this);

    ref.onDispose(() {
      _repository.removeUpdateListener(this);
    });

    return const LiveMeetingState(status: LiveMeetingStatus.idle);
  }

  Future<void> joinMeeting(String meetingId, String userName) async {
    state = state.copyWith(
      status: LiveMeetingStatus.joining,
      errorMessage: null,
    );
    try {
      await _repository.joinMeeting(meetingId: meetingId, userName: userName);
      final devices = await _repository.getAudioDevices();
      state = state.copyWith(availableAudioDevices: devices);
    } catch (e) {
      state = state.copyWith(
        status: LiveMeetingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> leaveMeeting() async {
    try {
      await _repository.leaveMeeting();
    } catch (_) {
      // Ignore database errors during leave to guarantee local state resets
    } finally {
      state = const LiveMeetingState(status: LiveMeetingStatus.disconnected);
    }
  }

  Future<void> toggleMic() async {
    await _repository.toggleMic();
  }

  Future<void> toggleCamera() async {
    await _repository.toggleCamera();
  }

  Future<void> toggleSpeakerPhone() async {
    if (state.activeAudioDevice == HMSAudioDevice.SPEAKER_PHONE) {
      final nonSpeaker = state.availableAudioDevices.firstWhere(
        (d) => d != HMSAudioDevice.SPEAKER_PHONE,
        orElse: () => HMSAudioDevice.EARPIECE,
      );
      await _repository.switchAudioOutput(nonSpeaker);
    } else {
      await _repository.switchAudioOutput(HMSAudioDevice.SPEAKER_PHONE);
    }
  }

  // ── HMSUpdateListener Implementation ───────────────────────────────────────

  @override
  void onJoin({required HMSRoom room}) {
    HMSLocalPeer? localPeer;
    try {
      localPeer = room.peers?.firstWhere((p) => p.isLocal) as HMSLocalPeer?;
    } catch (_) {}

    state = state.copyWith(
      status: LiveMeetingStatus.connected,
      localPeer: localPeer,
      remotePeers: room.peers?.where((p) => !p.isLocal).toList() ?? [],
      isMicMuted: localPeer?.audioTrack?.isMute ?? true,
      isCameraMuted: localPeer?.videoTrack?.isMute ?? true,
    );
  }

  @override
  void onRoomUpdate({required HMSRoom room, required HMSRoomUpdate update}) {}

  @override
  void onPeerUpdate({required HMSPeer peer, required HMSPeerUpdate update}) {
    final List<HMSPeer> updatedPeers = List.from(state.remotePeers);
    if (peer.isLocal) {
      state = state.copyWith(localPeer: peer as HMSLocalPeer);
      return;
    }

    switch (update) {
      case HMSPeerUpdate.peerJoined:
        if (!updatedPeers.any((p) => p.peerId == peer.peerId)) {
          updatedPeers.add(peer);
        }
        break;
      case HMSPeerUpdate.peerLeft:
        updatedPeers.removeWhere((p) => p.peerId == peer.peerId);
        break;
      case HMSPeerUpdate.roleUpdated:
      case HMSPeerUpdate.metadataChanged:
      case HMSPeerUpdate.nameChanged:
      case HMSPeerUpdate.networkQualityUpdated:
        final index = updatedPeers.indexWhere((p) => p.peerId == peer.peerId);
        if (index != -1) {
          updatedPeers[index] = peer;
        } else {
          updatedPeers.add(peer);
        }
        break;
      default:
        break;
    }
    state = state.copyWith(remotePeers: updatedPeers);
  }

  @override
  void onTrackUpdate({
    required HMSTrack track,
    required HMSTrackUpdate trackUpdate,
    required HMSPeer peer,
  }) {
    if (peer.isLocal) {
      if (track.kind == HMSTrackKind.kHMSTrackKindAudio) {
        state = state.copyWith(isMicMuted: track.isMute);
      } else if (track.kind == HMSTrackKind.kHMSTrackKindVideo) {
        state = state.copyWith(isCameraMuted: track.isMute);
      }
    } else {
      final updatedPeers = List<HMSPeer>.from(state.remotePeers);
      final index = updatedPeers.indexWhere((p) => p.peerId == peer.peerId);
      if (index != -1) {
        updatedPeers[index] = peer;
        state = state.copyWith(remotePeers: updatedPeers);
      }
    }
  }

  @override
  void onHMSError({required HMSException error}) {
    state = state.copyWith(
      status: LiveMeetingStatus.error,
      errorMessage: error.message,
    );
  }

  @override
  void onMessage({required HMSMessage message}) {}

  @override
  void onPeerListUpdate({
    required List<HMSPeer> addedPeers,
    required List<HMSPeer> removedPeers,
  }) {}

  @override
  void onUpdateSpeakers({required List<HMSSpeaker> updateSpeakers}) {}

  @override
  void onReconnecting() {
    state = state.copyWith(status: LiveMeetingStatus.reconnecting);
  }

  @override
  void onReconnected() {
    state = state.copyWith(status: LiveMeetingStatus.connected);
  }

  @override
  void onRoleChangeRequest({required HMSRoleChangeRequest roleChangeRequest}) {}

  @override
  void onChangeTrackStateRequest({
    required HMSTrackChangeRequest hmsTrackChangeRequest,
  }) {}

  @override
  void onRemovedFromRoom({
    required HMSPeerRemovedFromPeer hmsPeerRemovedFromPeer,
  }) {
    state = const LiveMeetingState(status: LiveMeetingStatus.disconnected);
  }

  @override
  void onAudioDeviceChanged({
    List<HMSAudioDevice>? availableAudioDevice,
    HMSAudioDevice? currentAudioDevice,
  }) {
    state = state.copyWith(
      activeAudioDevice: currentAudioDevice,
      availableAudioDevices: availableAudioDevice ?? [],
      isSpeakerPhoneOn: currentAudioDevice == HMSAudioDevice.SPEAKER_PHONE,
    );
  }

  @override
  void onSessionStoreAvailable({HMSSessionStore? hmsSessionStore}) {}
}
