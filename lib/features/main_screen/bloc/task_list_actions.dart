import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_info.dart';
import 'package:yandex_to_do_app/task_info.dart';

abstract class TaskListEvent {
  TaskListEvent();
}

class AddTaskEvent implements TaskListEvent {
  final TaskInfo task;
  const AddTaskEvent({required this.task});
}

class DeleteTaskEvent implements TaskListEvent {
  final String UUID;
  const DeleteTaskEvent({required this.UUID});
}

class ChangeTaskListStatusEvent implements TaskListEvent {
  final TaskListInfo taskList;
  const ChangeTaskListStatusEvent({required this.taskList});
}

class ChangeTaskStatusEvent implements TaskListEvent {
  final TaskInfo task;
  const ChangeTaskStatusEvent({required this.task});
}
