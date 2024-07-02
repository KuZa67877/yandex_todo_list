import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import '../../../data/task_api.dart';
import '../../../data/task.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskApi taskApi;
  bool _tasksLoaded = false;

  TaskListBloc({required this.taskApi}) : super(TaskListState.initial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<ChangeTaskStatusEvent>(_onChangeTaskStatus);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleShowCompletedTasksEvent>(_onToggleShowCompletedTasks);

    // Load tasks only once when the bloc is first created
    if (!_tasksLoaded) {
      _tasksLoaded = true;
      add(LoadTasksEvent());
    }
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskListState> emit) async {
    await emit.forEach<List<Task>>(
      taskApi.getTasks(),
      onData: (tasks) => state.copyWith(tasksList: tasks),
    );
  }

  Future<void> _onAddTask(
      AddTaskEvent event, Emitter<TaskListState> emit) async {
    await taskApi.addTask(event.task);
    add(LoadTasksEvent());
  }

  Future<void> _onChangeTaskStatus(
      ChangeTaskStatusEvent event, Emitter<TaskListState> emit) async {
    final updatedTask = event.task.copyWith(isDone: event.isDone);
    await taskApi.saveTask(updatedTask);

    // Update local state immediately
    final updatedTasksList = List<Task>.from(state.tasksList);
    final taskIndex =
        updatedTasksList.indexWhere((t) => t.UUID == event.task.UUID);
    if (taskIndex != -1) {
      updatedTasksList[taskIndex] = updatedTask;
      emit(state.copyWith(tasksList: updatedTasksList));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    await taskApi.deleteTask(event.task.UUID);

    // Update local state immediately
    final updatedTasksList = List<Task>.from(state.tasksList)
      ..removeWhere((t) => t.UUID == event.task.UUID);
    emit(state.copyWith(tasksList: updatedTasksList));
  }

  void _onToggleShowCompletedTasks(
      ToggleShowCompletedTasksEvent event, Emitter<TaskListState> emit) {
    emit(state.copyWith(showCompletedTasks: !state.showCompletedTasks));
  }
}
