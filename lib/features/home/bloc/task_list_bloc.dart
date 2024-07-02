import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/task.dart';
import 'task_list_event.dart';
import 'task_list_state.dart';

import 'package:bloc/bloc.dart';
import '../../../data/task_api.dart';

// part 'task_list_event.dart';
// part 'task_list_state.dart';
// part 'task_list_event.dart';
// part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskApi taskApi;

  TaskListBloc({required this.taskApi}) : super(TaskListState.initial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<ChangeTaskStatusEvent>(_onChangeTaskStatus);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleShowCompletedTasksEvent>(_onToggleShowCompletedTasks);
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
    await taskApi.saveTask(event.task);
    add(LoadTasksEvent());
  }

  Future<void> _onChangeTaskStatus(
      ChangeTaskStatusEvent event, Emitter<TaskListState> emit) async {
    final updatedTask = event.task.copyWith(isDone: event.isDone);
    await taskApi.saveTask(updatedTask);
    add(LoadTasksEvent());
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    await taskApi.deleteTask(event.task.UUID);
    add(LoadTasksEvent());
  }

  void _onToggleShowCompletedTasks(
      ToggleShowCompletedTasksEvent event, Emitter<TaskListState> emit) {
    emit(state.copyWith(showCompletedTasks: !state.showCompletedTasks));
  }
}
