// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:distributor_os/features/meetings/presentation/pages/meeting_replay_page.dart';
import 'package:distributor_os/features/meetings/presentation/providers/meeting_replay_provider.dart';
import 'package:distributor_os/features/meetings/domain/entities/meeting.dart';
import 'package:distributor_os/features/meetings/domain/entities/meeting_status.dart';
import 'package:distributor_os/features/meetings/domain/entities/meeting_attendance.dart';
import 'package:distributor_os/features/meetings/domain/entities/attendance_status.dart';

class FakeVideoPlayerPlatform extends VideoPlayerPlatform
    with MockPlatformInterfaceMixin {
  @override
  Future<void> init() async {}

  @override
  Future<int> create(DataSource dataSource) async {
    return 1;
  }

  @override
  Future<void> dispose(int textureId) async {}

  @override
  Future<void> play(int textureId) async {}

  @override
  Future<void> pause(int textureId) async {}

  @override
  Future<void> setVolume(int textureId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {}

  @override
  Future<void> seekTo(int textureId, Duration position) async {}

  @override
  Future<void> setLooping(int textureId, bool looping) async {}

  @override
  Widget buildView(int textureId) {
    return const SizedBox.shrink();
  }

  @override
  Future<Duration> getPosition(int textureId) async {
    return Duration.zero;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return Stream.value(VideoEvent(
      eventType: VideoEventType.initialized,
      duration: const Duration(minutes: 72),
      size: const Size(1920, 1080),
    ));
  }
}

void main() {
  setUpAll(() {
    VideoPlayerPlatform.instance = FakeVideoPlayerPlatform();
  });

  testWidgets('MeetingReplayPage renders and shows metadata and attendance report', (WidgetTester tester) async {
    // Increase physical size to fit the entire page in test viewport without lazy-loading pruning
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;
    
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final mockMeeting = Meeting(
      id: 'test-meeting-id',
      companyId: 'company-1',
      leaderId: 'leader-1',
      meetingCode: 'CODE123',
      title: 'Branch Strategy: Q3 Planning',
      meetingStatus: MeetingStatus.completed,
      scheduledAt: DateTime(2023, 10, 24, 10, 0),
      durationMinutes: 72,
      recordingEnabled: true,
      recordingUrl: 'https://example.com/recording.mp4',
      lateJoinAllowed: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final mockAttendance = MeetingAttendance(
      id: 'attendance-1',
      meetingId: 'test-meeting-id',
      profileId: 'profile-1',
      firstJoinedAt: DateTime(2023, 10, 24, 10, 2),
      lastLeftAt: DateTime(2023, 10, 24, 11, 10),
      totalDurationMinutes: 68,
      attendancePercentage: 94.4,
      attendanceStatus: AttendanceStatus.attended,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final mockAttendee = AttendanceWithProfile(
      attendance: mockAttendance,
      fullName: 'Priya Sharma',
      email: 'priya@example.com',
      distributorId: 'DST001',
    );

    final mockReplayData = ReplayViewModel(
      meeting: mockMeeting,
      attendances: [mockAttendee],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meetingReplayProvider('test-meeting-id').overrideWith(
            (ref) => Future.value(mockReplayData),
          ),
        ],
        child: const MaterialApp(
          home: MeetingReplayPage(meetingId: 'test-meeting-id'),
        ),
      ),
    );

    // Let the provider resolve the future
    await tester.pump();
    // Wait for the video initialization microtasks to run
    await tester.pumpAndSettle();



    // Verify Title & Date Info
    expect(find.text('Branch Strategy: Q3 Planning'), findsWidgets);
    expect(find.text('Oct 24, 2023'), findsOneWidget);
    expect(find.text('72m'), findsOneWidget);

    // Verify Attendance Section
    expect(find.text('Attendance Report'), findsOneWidget);
    expect(find.text('1/1 compliant'), findsOneWidget);
    expect(find.text('Priya Sharma'), findsOneWidget);
    expect(find.text('Compliant'), findsOneWidget);

    // Verify Export Button is present
    expect(find.text('EXPORT REPORT'), findsOneWidget);
  });
}
