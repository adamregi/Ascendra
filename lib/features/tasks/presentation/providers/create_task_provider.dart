import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_priority.dart';

part 'create_task_provider.g.dart';

class CreateTaskState {
  final String title;
  final String taskType;
  final Set<String> proofRequirements;
  final String assignmentType; // 'segments', 'branches', 'individuals'
  final DateTime? dueDate;
  final bool isSubmitting;

  const CreateTaskState({
    this.title = '',
    this.taskType = 'recruitment',
    this.proofRequirements = const {
      'Mobile Numbers',
      'Contact Names',
      'Screenshot',
    },
    this.assignmentType = 'segments',
    this.dueDate,
    this.isSubmitting = false,
  });

  CreateTaskState copyWith({
    String? title,
    String? taskType,
    Set<String>? proofRequirements,
    String? assignmentType,
    DateTime? dueDate,
    bool? isSubmitting,
  }) {
    return CreateTaskState(
      title: title ?? this.title,
      taskType: taskType ?? this.taskType,
      proofRequirements: proofRequirements ?? this.proofRequirements,
      assignmentType: assignmentType ?? this.assignmentType,
      dueDate: dueDate ?? this.dueDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

@riverpod
class CreateTaskController extends _$CreateTaskController {
  @override
  CreateTaskState build() => const CreateTaskState();

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void selectTaskType(String type) {
    state = state.copyWith(taskType: type);
  }

  void toggleProofRequirement(String requirement) {
    final current = Set<String>.from(state.proofRequirements);
    if (current.contains(requirement)) {
      current.remove(requirement);
    } else {
      current.add(requirement);
    }
    state = state.copyWith(proofRequirements: current);
  }

  void selectAssignmentType(String type) {
    state = state.copyWith(assignmentType: type);
  }

  void setDueDate(DateTime date) {
    state = state.copyWith(dueDate: date);
  }

  Future<void> submit() async {
    state = state.copyWith(isSubmitting: true);
    // Simulate network delay for creating campaign
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isSubmitting: false);
  }
}
