import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/features/meetings/presentation/widgets/meeting_controls.dart';

void main() {
  testWidgets('MeetingControls renders correct icons based on state', (
    WidgetTester tester,
  ) async {
    bool micToggled = false;
    bool cameraToggled = false;
    bool speakerToggled = false;
    bool leftCall = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MeetingControls(
            isMicMuted: true,
            isCameraMuted: false,
            isSpeakerPhoneOn: true,
            onToggleMic: () => micToggled = true,
            onToggleCamera: () => cameraToggled = true,
            onToggleSpeaker: () => speakerToggled = true,
            onLeave: () => leftCall = true,
          ),
        ),
      ),
    );

    // Verify icons match state
    expect(find.byIcon(Icons.mic_off), findsOneWidget);
    expect(find.byIcon(Icons.videocam), findsOneWidget);
    expect(find.byIcon(Icons.volume_up), findsOneWidget);
    expect(find.byIcon(Icons.call_end), findsOneWidget);

    // Tap Mic and verify callback
    await tester.tap(find.byIcon(Icons.mic_off));
    expect(micToggled, isTrue);

    // Tap Camera and verify callback
    await tester.tap(find.byIcon(Icons.videocam));
    expect(cameraToggled, isTrue);

    // Tap Speaker and verify callback
    await tester.tap(find.byIcon(Icons.volume_up));
    expect(speakerToggled, isTrue);

    // Tap Leave and verify callback
    await tester.tap(find.byIcon(Icons.call_end));
    expect(leftCall, isTrue);
  });
}
