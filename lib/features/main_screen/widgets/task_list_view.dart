import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:yandex_to_do_app/features/main_screen/bloc/task_list_bloc.dart";
import "package:yandex_to_do_app/features/main_screen/widgets/task_item_widget.dart";

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskListBloc>();
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      return TaskItemWidget(taskInfo: bloc.state.tasksList![index]);
    });
  }
}
