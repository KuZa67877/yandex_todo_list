import 'package:yandex_to_do_app/features/main_screen/bloc/task_info.dart';

class TaskListInfo {
  final List<TaskInfo>? tasksList;
  final int doneTasksCount;
  final TaskListStatus status;
  TaskListInfo(
      {this.tasksList,
      this.doneTasksCount = 0,
      this.status = TaskListStatus.showNotComplitedTasks});
}

enum TaskListStatus {
  showAllTasks,
  showNotComplitedTasks,
}
