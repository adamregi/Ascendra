import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/features/meetings/presentation/widgets/participant_tile.dart';
import '../../meetings_test_mocks.dart';

void main() {
  testWidgets('ParticipantTile displays name, host badge, and mic status', (
    WidgetTester tester,
  ) async {
    final hostRole = MockHMSRole(name: 'host');
    final peer = MockHMSRemotePeer(
      name: 'Michael Scott',
      peerId: 'peer-1',
      role: hostRole,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ParticipantTile(peer: peer, isSpeaking: true)),
      ),
    );

    // Verify name is rendered
    expect(find.text('Michael Scott'), findsOneWidget);

    // Verify HOST badge is rendered
    expect(find.text('HOST'), findsOneWidget);

    // Verify SPEAKING indicator is rendered
    expect(find.text('SPEAKING'), findsOneWidget);

    // Verify muted mic icon is rendered by default (since audioTrack is null -> muted = true)
    expect(find.byIcon(Icons.mic_off), findsOneWidget);
  });
}
