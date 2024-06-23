import 'package:yandex_to_do_app/features/main_screen/bloc/task_info.dart';
import 'package:yandex_to_do_app/task_status.dart';

class ChangeTaskState {
  final bool haveTask;
  final TaskInfo? editedTask;
  final TaskStatusMode status;

  ChangeTaskState({
    this.status = TaskStatusMode.standartMode,
    this.haveTask = false,
    this.editedTask,
  });

  ChangeTaskState copyWith({
    bool? haveTask,
    TaskInfo? editedTask,
    TaskStatusMode? status,
  }) {
    return ChangeTaskState(
      haveTask: haveTask ?? this.haveTask,
      editedTask: editedTask ?? this.editedTask,
      status: status ?? this.status,
    );
  }
}
