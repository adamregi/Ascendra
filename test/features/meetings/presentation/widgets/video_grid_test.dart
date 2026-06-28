import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/features/meetings/presentation/widgets/video_grid.dart';
import 'package:distributor_os/features/meetings/presentation/widgets/participant_tile.dart';
import '../../meetings_test_mocks.dart';

void main() {
  testWidgets('VideoGrid renders single participant', (WidgetTester tester) async {
    final guestRole = MockHMSRole(name: 'guest');
    final localPeer = MockHMSLocalPeer(
      name: 'Pam Beesly',
      peerId: 'local-1',
      role: guestRole,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoGrid(
            localPeer: localPeer,
            remotePeers: const [],
          ),
        ),
      ),
    );

    expect(find.byType(ParticipantTile), findsOneWidget);
    expect(find.text('Pam Beesly'), findsOneWidget);
  });

  testWidgets('VideoGrid renders multiple participants', (WidgetTester tester) async {
    final guestRole = MockHMSRole(name: 'guest');
    final localPeer = MockHMSLocalPeer(
      name: 'Pam Beesly',
      peerId: 'local-1',
      role: guestRole,
    );
    final remotePeer = MockHMSRemotePeer(
      name: 'Jim Halpert',
      peerId: 'remote-1',
      role: guestRole,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoGrid(
            localPeer: localPeer,
            remotePeers: [remotePeer],
          ),
        ),
      ),
    );

    expect(find.byType(ParticipantTile), findsNWidgets(2));
    expect(find.text('Pam Beesly'), findsOneWidget);
    expect(find.text('Jim Halpert'), findsOneWidget);
  });
}
