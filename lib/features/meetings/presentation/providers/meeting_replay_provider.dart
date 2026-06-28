import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/replay_view_model.dart';
import 'meetings_providers.dart';

part 'meeting_replay_provider.g.dart';

@riverpod
Future<ReplayViewModel> meetingReplay(Ref ref, String meetingId) async {
  final repository = ref.watch(meetingReplayRepositoryProvider);
  return repository.getMeetingReplayData(meetingId);
}
