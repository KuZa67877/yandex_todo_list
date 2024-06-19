import 'package:yandex_to_do_app/bloc/task_list/task_list_info.dart';
import 'package:yandex_to_do_app/task_info.dart';

abstract class TaskListActions {
  TaskListActions();
}

class AddTaskAction implements TaskListActions {
  final TaskInfo task;
  const AddTaskAction({required this.task});
}

class DeleteTaskAction implements TaskListActions {
  final String taskIndificator;
  const DeleteTaskAction({required this.taskIndificator});
}

class ChangeTaskListStatusAction implements TaskListActions {
  final TaskListInfo taskList;
  const ChangeTaskListStatusAction({required this.taskList});
}

class ChangeTaskStatusAction implements TaskListActions {
  final TaskInfo task;
  const ChangeTaskStatusAction({required this.task});
}
