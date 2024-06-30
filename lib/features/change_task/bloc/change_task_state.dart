part of 'change_task_bloc.dart';

class ChangeTaskState {
  final bool haveTask;
  final Task? editedTask;
  final TaskStatusMode status;

  ChangeTaskState({
    this.status = TaskStatusMode.standartMode,
    this.haveTask = false,
    this.editedTask,
  });

  ChangeTaskState copyWith({
    bool? haveTask,
    Task? editedTask,
    TaskStatusMode? status,
  }) {
    return ChangeTaskState(
      haveTask: haveTask ?? this.haveTask,
      editedTask: editedTask ?? this.editedTask,
      status: status ?? this.status,
    );
  }
}
