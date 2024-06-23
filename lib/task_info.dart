import 'package:uuid/uuid.dart';
import 'task_status.dart';

class TaskInfo {
  late final String UUID;
  final bool isDone;
  final String taskInfo;
  final TaskStatusMode taskMode;
  final DateTime? taskDeadline;

  TaskInfo({
    required this.UUID,
    required this.taskInfo,
    this.isDone = false,
    this.taskMode = TaskStatusMode.standartMode,
    this.taskDeadline,
  });

  TaskInfo copyWith({
    bool? isDone,
    String? taskInfo,
    TaskStatusMode? taskMode,
    DateTime? taskDeadline,
  }) {
    return TaskInfo(
      UUID: this.UUID,
      taskInfo: taskInfo ?? this.taskInfo,
      isDone: isDone ?? this.isDone,
      taskMode: taskMode ?? this.taskMode,
      taskDeadline: taskDeadline ?? this.taskDeadline,
    );
  }
}
