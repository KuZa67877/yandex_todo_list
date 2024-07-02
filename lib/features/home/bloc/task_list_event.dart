import 'package:equatable/equatable.dart';

import '../../../data/task.dart';
import 'task_list_state.dart';

//part of 'task_list_bloc.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskListEvent {}

class AddTaskEvent extends TaskListEvent {
  final Task task;

  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class ChangeTaskStatusEvent extends TaskListEvent {
  final Task task;
  final bool isDone;

  const ChangeTaskStatusEvent({required this.task, required this.isDone});

  @override
  List<Object?> get props => [task, isDone];
}

class DeleteTaskEvent extends TaskListEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class ToggleShowCompletedTasksEvent extends TaskListEvent {}
