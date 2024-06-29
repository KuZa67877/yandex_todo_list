import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/logger.dart';
import '../../../resourses/colors.dart';
import '../../change_task/change_task_screen.dart';
import '../../../data/task.dart';
import 'package:intl/intl.dart';
import '../bloc/task_list_bloc.dart';
import '../bloc/task_list_event.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskListBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Dismissible(
        key: Key(task.UUID),
        background: _buildSwipeActionLeft(context),
        secondaryBackground: _buildSwipeActionRight(context),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            bloc.add(ChangeTaskStatusEvent(task: task, isDone: !task.isDone));
            logger.d('Task status changed: ${task.taskInfo}');
          } else if (direction == DismissDirection.endToStart) {
            bloc.add(DeleteTaskEvent(task: task));
            logger.d('Task deleted: ${task.taskInfo}');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${taskStatus(task.taskMode)}${task.taskInfo}',
                  maxLines: 3,
                  style: TextStyle(
                    decoration: task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: task.isDone
                        ? AppColors.lightLabelTertiary
                        : AppColors.lightLabelPrimary,
                  ),
                ),
                if (task.taskDeadline != null)
                  Text(
                    FormatDate.toDmmmmyyyy(task.taskDeadline!),
                    style: const TextStyle(
                      color: AppColors.lightBackSecondary,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            leading: IconButton(
              onPressed: () => bloc
                  .add(ChangeTaskStatusEvent(task: task, isDone: !task.isDone)),
              icon: Icon(
                task.isDone ? Icons.check_box : Icons.crop_square_outlined,
                color: task.taskMode == TaskStatusMode.highPriorityMode &&
                        !task.isDone
                    ? AppColors.lightColorRed
                    : AppColors.lightLabelTertiary,
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                logger.d(
                    'Navigating to edit task screen for task: ${task.taskInfo}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeTaskScreen(task: task),
                  ),
                );
              },
              icon: const Icon(
                Icons.info_outline,
                color: AppColors.lightLabelTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeActionLeft(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logger.d('Completed task: ${task.taskInfo}');
      },
      child: Container(
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeActionRight(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logger.d('Deleted task: ${task.taskInfo}');
      },
      child: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

String taskStatus(TaskStatusMode mode) {
  switch (mode) {
    case TaskStatusMode.highPriorityMode:
      return '!! ';
    case TaskStatusMode.lowPriorityMode:
      return '↓ ';
    default:
      return '';
  }
}

class FormatDate {
  static String toDmmmmyyyy(DateTime date) {
    return '${DateFormat.d().format(date)} ${DateFormat.MMMM('ru').format(date)} ${DateFormat.y().format(date)}';
  }
}
