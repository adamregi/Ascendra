import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../followups/domain/entities/followup.dart';

part 'task_followups_provider.g.dart';

@riverpod
Future<List<FollowUp>> taskFollowups(
  TaskFollowupsRef ref,
  String taskId,
) async {
  // Mock data for the thread view
  await Future.delayed(const Duration(milliseconds: 500));
  return []; // Empty for now, the UI will handle the empty state
}
