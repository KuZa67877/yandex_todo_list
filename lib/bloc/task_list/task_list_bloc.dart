import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_to_do_app/bloc/task_list/task_list_info.dart';
import 'package:yandex_to_do_app/task_info.dart';

import 'task_list_actions.dart';

class TaskListBloc extends Bloc<TaskListActions, TaskListInfo> {
  TaskListBloc() : super(TaskListInfo(tasksList: [])) {
    on<AddTaskAction>(_addTask);
    on<DeleteTaskAction>(_deleteTask);
    on<ChangeTaskListStatusAction>(_changeTaskListStatus);
    on<ChangeTaskStatusAction>(_changeTaskStatus);
  }

  Future<void> _addTask(AddTaskAction event, Emitter<TaskListInfo> emit) async {
    final updatedTasks = List<TaskInfo>.from(state.tasksList ?? [])
      ..add(event.task);
    emit(TaskListInfo(
      tasksList: updatedTasks,
      doneTasksCount: updatedTasks.where((task) => task.isDone).length,
      status: state.status,
    ));
  }

  Future<void> _deleteTask(
      DeleteTaskAction event, Emitter<TaskListInfo> emit) async {
    // final updatedTasks = List<TaskInfo>.from(state.tasksList ?? [])..removeWhere((task) => task.id == event.taskIndificator);
    // emit(TaskListInfo(
    //   tasksList: updatedTasks,
    //   doneTasksCount: updatedTasks.where((task) => task.isDone).length,
    //   status: state.status,
    // ));
  }

  Future<void> _changeTaskListStatus(
      ChangeTaskListStatusAction event, Emitter<TaskListInfo> emit) async {
    emit(TaskListInfo(
      tasksList: state.tasksList,
      doneTasksCount: state.doneTasksCount,
      status: event.taskList.status,
    ));
  }

  Future<void> _changeTaskStatus(
      ChangeTaskStatusAction event, Emitter<TaskListInfo> emit) async {
    // final updatedTasks = state.tasksList?.map((task) {
    //   return task.id == event.task.id ? event.task : task;
    // }).toList();
    // emit(TaskListInfo(
    //   tasksList: updatedTasks,
    //   doneTasksCount: updatedTasks?.where((task) => task.isDone).length ?? 0,
    //   status: state.status,
    // ));
  }
}
