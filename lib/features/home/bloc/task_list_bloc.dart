import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/entities/task.dart';
import '../../../core/domain/repository/task_repository.dart';
import '../../../core/utils/logger.dart';
part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskRepository taskRepository;
  bool _tasksLoaded = false;

  TaskListBloc({required this.taskRepository})
      : super(TaskListState.initial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<ChangeTaskStatusEvent>(_onChangeTaskStatus);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleShowCompletedTasksEvent>(_onToggleShowCompletedTasks);

    if (!_tasksLoaded) {
      _tasksLoaded = true;
      add(LoadTasksEvent());
    }
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskListState> emit) async {
    try {
      final tasks = await taskRepository.getTasks();
      emit(state.copyWith(
        tasksList: tasks,
        doneTasksCount: tasks.where((task) => task.done).length,
      ));
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onAddTask(
      AddTaskEvent event, Emitter<TaskListState> emit) async {
    await taskRepository.addTask(event.task);
    add(LoadTasksEvent());
    //await _patchTasks(emit);
  }

  Future<void> _onChangeTaskStatus(
      ChangeTaskStatusEvent event, Emitter<TaskListState> emit) async {
    final updatedTask = event.task.copyWith(isDone: event.isDone);
    await taskRepository.updateTask(updatedTask);

    final updatedTasksList = List<Task>.from(state.tasksList);
    final taskIndex = updatedTasksList.indexWhere((t) => t.id == event.task.id);
    if (taskIndex != -1) {
      updatedTasksList[taskIndex] = updatedTask;
      emit(state.copyWith(
        tasksList: updatedTasksList,
        doneTasksCount: updatedTasksList.where((task) => task.done).length,
      ));
    }
    //await _patchTasks(emit);
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    await taskRepository.deleteTask(event.task.id);

    final updatedTasksList = List<Task>.from(state.tasksList)
      ..removeWhere((t) => t.id == event.task.id);
    emit(state.copyWith(
      tasksList: updatedTasksList,
      doneTasksCount: updatedTasksList.where((task) => task.done).length,
    ));
  }

  void _onToggleShowCompletedTasks(
      ToggleShowCompletedTasksEvent event, Emitter<TaskListState> emit) {
    emit(state.copyWith(showCompletedTasks: !state.showCompletedTasks));
  }

  Future<void> _patchTasks(Emitter<TaskListState> emit) async {
    try {
      await taskRepository.patchTasks(state.tasksList);
    } catch (e) {
      logger.e("Tasks patch error");
    }
  }
}
