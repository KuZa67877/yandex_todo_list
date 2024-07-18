part of 'change_task_bloc.dart';

class ChangeTaskState extends Equatable {
  final bool haveTask;
  final Task? editedTask;
  final TaskStatusMode status;

  const ChangeTaskState({
    this.status = TaskStatusMode.basic,
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

  @override
  List<Object?> get props => [haveTask, editedTask, status];
}
