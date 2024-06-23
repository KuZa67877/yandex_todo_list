import "package:flutter/material.dart";
import "package:yandex_to_do_app/features/main_screen/widgets/add_task_batton.dart";
import "package:yandex_to_do_app/features/main_screen/widgets/task_item_widget.dart";
import "package:yandex_to_do_app/features/main_screen/bloc/task_info.dart";
import "package:yandex_to_do_app/task_status.dart";

class TaskListViewWidget extends StatelessWidget {
  final List<TaskInfo>? tasks;

  const TaskListViewWidget({Key? key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks == null || tasks!.isEmpty) {
      return Column(
        children: [
          TaskItemWidget(
            task: TaskInfo(
                UUID: "UUID",
                taskInfo: "Первая задача",
                taskMode: TaskStatusMode.highPriorityMode),
          ),
          TaskItemWidget(
            task: TaskInfo(
                UUID: "UUID",
                taskInfo: "Вторая задача",
                taskMode: TaskStatusMode.standartMode),
          ),
          TaskItemWidget(
            task: TaskInfo(
                UUID: "UUID",
                taskInfo: "Третья задача",
                taskMode: TaskStatusMode.standartMode,
                isDone: true),
          ),
          TaskItemWidget(
            task: TaskInfo(
                UUID: "UUID",
                taskInfo: "Опять третья задача",
                taskMode: TaskStatusMode.lowPriorityMode),
          ),
          AddNewTaskItemWidget()
        ],
      );
    }

    return ListView.builder(
      itemCount: tasks!.length,
      itemBuilder: (context, index) {
        final task = tasks![index];
        return ListTile(
          title: Text(task.taskInfo),
        );
      },
    );
  }
}
