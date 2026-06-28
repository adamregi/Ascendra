import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:mockito/mockito.dart';

class MockHMSLocalPeer extends Mock implements HMSLocalPeer {
  @override
  final String name;
  @override
  final String peerId;
  @override
  final HMSRole role;
  @override
  final HMSVideoTrack? videoTrack;
  @override
  final HMSAudioTrack? audioTrack;
  @override
  final bool isLocal = true;

  MockHMSLocalPeer({
    required this.name,
    required this.peerId,
    required this.role,
    this.videoTrack,
    this.audioTrack,
  });
}

class MockHMSRemotePeer extends Mock implements HMSRemotePeer {
  @override
  final String name;
  @override
  final String peerId;
  @override
  final HMSRole role;
  @override
  final HMSVideoTrack? videoTrack;
  @override
  final HMSAudioTrack? audioTrack;
  @override
  final bool isLocal = false;

  MockHMSRemotePeer({
    required this.name,
    required this.peerId,
    required this.role,
    this.videoTrack,
    this.audioTrack,
  });
}

class MockHMSRole extends Mock implements HMSRole {
  @override
  final String name;

  MockHMSRole({required this.name});
}
