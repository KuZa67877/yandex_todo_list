import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_actions.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_info.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_info.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListInfo> {
  TaskListBloc() : super(TaskListInfo(tasksList: [])) {
    // Начальное состояние без задач
    on<AddTaskEvent>(_addTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<ChangeTaskListStatusEvent>(_changeTaskListStatus);
    on<ChangeTaskStatusEvent>(_changeTaskStatus);
  }

  Future<void> _addTask(AddTaskEvent event, Emitter<TaskListInfo> emit) async {
    final updatedTasks = List<TaskInfo>.from(state.tasksList ?? [])
      ..add(event.task);
    emit(TaskListInfo(
      tasksList: updatedTasks,
      doneTasksCount: updatedTasks.where((task) => task.isDone).length,
      status: state.status,
    ));
  }

  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskListInfo> emit) async {}

  Future<void> _changeTaskListStatus(
      ChangeTaskListStatusEvent event, Emitter<TaskListInfo> emit) async {
    emit(TaskListInfo(
      tasksList: state.tasksList,
      doneTasksCount: state.doneTasksCount,
      status: event.taskList.status,
    ));
  }

  Future<void> _changeTaskStatus(
      ChangeTaskStatusEvent event, Emitter<TaskListInfo> emit) async {}
}
