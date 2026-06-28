import '../entities/replay_view_model.dart';

abstract class MeetingReplayRepository {
  /// Fetches the meeting, its attendances, and associated profiles,
  /// then composes them into a complete ReplayViewModel.
  Future<ReplayViewModel> getMeetingReplayData(String meetingId);
}
