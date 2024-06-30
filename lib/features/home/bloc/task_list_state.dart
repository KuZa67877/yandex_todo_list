part of 'task_list_bloc.dart';

class TaskListState extends Equatable {
  final List<Task> tasksList;
  final bool showCompletedTasks;
  final int doneTasksCount;

  const TaskListState({
    required this.tasksList,
    required this.showCompletedTasks,
    required this.doneTasksCount,
  });

  factory TaskListState.initial() {
    return const TaskListState(
      tasksList: [],
      showCompletedTasks: true,
      doneTasksCount: 0,
    );
  }

  TaskListState copyWith({
    List<Task>? tasksList,
    bool? showCompletedTasks,
  }) {
    return TaskListState(
      tasksList: tasksList ?? this.tasksList,
      showCompletedTasks: showCompletedTasks ?? this.showCompletedTasks,
      doneTasksCount:
          tasksList?.where((task) => task.isDone).length ?? this.doneTasksCount,
    );
  }

  @override
  List<Object?> get props => [tasksList, showCompletedTasks, doneTasksCount];
}
