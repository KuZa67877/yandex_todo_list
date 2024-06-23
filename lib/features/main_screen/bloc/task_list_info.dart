import 'package:yandex_to_do_app/task_info.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_status.dart';

class TaskListInfo {
  final List<TaskInfo>? tasksList;
  final int doneTasksCount;
  final TaskListStatus status;
  TaskListInfo(
      {this.tasksList,
      this.doneTasksCount = 0,
      this.status = TaskListStatus.showNotComplitedTasks});
}
