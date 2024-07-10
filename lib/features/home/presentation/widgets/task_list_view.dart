import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/task.dart';
import '../../bloc/task_list_bloc.dart';
import 'task_item_widget.dart';

class TaskListViewWidget extends StatelessWidget {
  final List<Task> tasks;

  const TaskListViewWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        final filteredTasks = state.showCompletedTasks
            ? state.tasksList
            : state.tasksList.where((task) => !task.done).toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return TaskItemWidget(
                task: filteredTasks[index],
                key: UniqueKey(),
              );
            },
            childCount: filteredTasks.length,
          ),
        );
      },
    );
  }
}
