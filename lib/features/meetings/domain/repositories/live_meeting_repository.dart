import 'package:hmssdk_flutter/hmssdk_flutter.dart';

/// Repository contract for real-time live meeting operations.
abstract class LiveMeetingRepository {
  /// Join a live meeting by fetching the token from the backend and connecting via 100ms.
  Future<void> joinMeeting({
    required String meetingId,
    required String userName,
  });

  /// Disconnect and leave the current meeting room.
  Future<void> leaveMeeting();

  /// Toggle local microphone mute state.
  Future<void> toggleMic();

  /// Toggle local camera mute state.
  Future<void> toggleCamera();

  /// Register an update listener to receive 100ms room events.
  void addUpdateListener(HMSUpdateListener listener);

  /// Remove a previously registered update listener.
  void removeUpdateListener(HMSUpdateListener listener);

  /// Query the list of available audio routing devices.
  Future<List<HMSAudioDevice>> getAudioDevices();

  /// Switch the active audio output device.
  Future<void> switchAudioOutput(HMSAudioDevice device);
}
