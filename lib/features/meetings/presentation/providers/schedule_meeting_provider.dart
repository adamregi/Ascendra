import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../app/providers/repository_providers.dart';
import '../../../profile/providers/profile_provider.dart';

part 'schedule_meeting_provider.g.dart';

enum MeetingDuration {
  thirty(30, '30 Min'),
  fortyFive(45, '45 Min'),
  sixty(60, '1 Hour'),
  custom(null, 'Custom');

  final int? minutes;
  final String label;
  const MeetingDuration(this.minutes, this.label);
}

class ScheduleMeetingDraft {
  final String title;
  final String? agenda;
  final DateTime? scheduledAt;
  final MeetingDuration duration;
  final List<String> participantIds;
  final bool reminderEnabled;

  const ScheduleMeetingDraft({
    this.title = '',
    this.agenda,
    this.scheduledAt,
    this.duration = MeetingDuration.thirty,
    this.participantIds = const [],
    this.reminderEnabled = true,
  });

  ScheduleMeetingDraft copyWith({
    String? title,
    String? agenda,
    DateTime? scheduledAt,
    MeetingDuration? duration,
    List<String>? participantIds,
    bool? reminderEnabled,
  }) {
    return ScheduleMeetingDraft(
      title: title ?? this.title,
      agenda: agenda ?? this.agenda,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      duration: duration ?? this.duration,
      participantIds: participantIds ?? this.participantIds,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    );
  }
}

@riverpod
class ScheduleMeetingNotifier extends _$ScheduleMeetingNotifier {
  @override
  ScheduleMeetingDraft build() {
    return const ScheduleMeetingDraft();
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDate(DateTime date) {
    final current = state.scheduledAt ?? DateTime.now();
    final newDate = DateTime(date.year, date.month, date.day, current.hour, current.minute);
    state = state.copyWith(scheduledAt: newDate);
  }

  void updateTime(int hour, int minute) {
    final current = state.scheduledAt ?? DateTime.now();
    final newDate = DateTime(current.year, current.month, current.day, hour, minute);
    state = state.copyWith(scheduledAt: newDate);
  }

  void updateDuration(MeetingDuration duration) {
    state = state.copyWith(duration: duration);
  }

  Future<void> submit() async {
    if (state.title.isEmpty || state.scheduledAt == null) {
      throw Exception('Title and date/time are required.');
    }
    
    final repo = ref.read(meetingRepositoryProvider);
    final profile = ref.read(profileProvider).value;
    if (profile == null) throw Exception('Profile not loaded');
    
    await repo.scheduleMeeting(
      companyId: profile.companyId,
      leaderId: profile.id,
      title: state.title,
      scheduledAt: state.scheduledAt!,
      durationMinutes: state.duration.minutes,
      agenda: state.agenda,
    );
  }
}
