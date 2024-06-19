import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/task_info.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskInfo taskInfo;
  const TaskItemWidget({super.key, required this.taskInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween, //TODO добавить случаи, когда текст перечеркнут в случае если таска выполнена и отображается + свайпы реализовать
      children: [
        Checkbox(value: taskInfo.isDone, onChanged: taskIsDone),
        Text(taskInfo.taskInfo),
        IconButton(onPressed: watchTaskInfo, icon: Icon(Icons.info_outline))
      ],
    );
  }
}

void taskIsDone(bool? isDone) {}

void watchTaskInfo() {}
