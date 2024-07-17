import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/di.dart';
import '../../../../core/domain/entities/task.dart';
import '../../../../core/resourses/colors.dart';
import '../../../../core/utils/local_remote.dart';
import '../../../../core/utils/logger.dart';
import '../../../../routes/router_delegate.dart';
import '../../bloc/task_list_bloc.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final localRemote = ServiceLocator.getIt<LocalRemote>();

    final bloc = context.read<TaskListBloc>();
    final ToDoRouterDelegate routerDelegate =
        Router.of(context).routerDelegate as ToDoRouterDelegate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Dismissible(
        key: Key(task.id),
        background: _buildSwipeActionLeft(context),
        secondaryBackground: _buildSwipeActionRight(context),
        onDismissed: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            if (task.done == false) {
              bloc.add(ChangeTaskStatusEvent(task: task, isDone: true));
              logger.d('Task marked as done: ${task.taskInfo}');

              await FirebaseAnalytics.instance.logEvent(name: "taks_done");
            }
          } else if (direction == DismissDirection.endToStart) {
            bloc.add(DeleteTaskEvent(task: task));
            logger.d('Task deleted: ${task.taskInfo}');
            await FirebaseAnalytics.instance.logEvent(name: "taks_deleted");
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${taskStatus(task.taskMode)}${task.taskInfo}',
                  style: TextStyle(
                    decoration: task.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (task.taskDeadline != null)
                  Text(
                    FormatDate.toDmmmmyyyy(task.taskDeadline!),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            leading: IconButton(
              onPressed: () async {
                bloc.add(ChangeTaskStatusEvent(task: task, isDone: !task.done));

                await FirebaseAnalytics.instance.logEvent(name: "taks_done");
              },
              icon: Icon(
                task.done ? Icons.check_box : Icons.crop_square_outlined,
                color: task.taskMode == TaskStatusMode.important &&
                        localRemote.getTaskColour()
                    ? AppColors.darkColorRed
                    : const Color(0xff793cd8),
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                logger.d(
                    'Navigating to edit task screen for task: ${task.taskInfo}');
                routerDelegate.editTask(task);

                await FirebaseAnalytics.instance
                    .logEvent(name: "navigating_to_edit_task_screen");
              },
              icon: const Icon(
                Icons.info_outline,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeActionLeft(BuildContext context) {
    final bloc = context.read<TaskListBloc>();
    return GestureDetector(
      onTap: () async {
        if (!task.done) {
          logger.d('Completed task: ${task.taskInfo}');
          await FirebaseAnalytics.instance.logEvent(name: "taks_done");
          bloc.add(ChangeTaskStatusEvent(task: task, isDone: true));
        }
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
    final bloc = context.read<TaskListBloc>();
    return GestureDetector(
      onTap: () async {
        logger.d('Deleted task: ${task.taskInfo}');
        bloc.add(DeleteTaskEvent(task: task));
        await FirebaseAnalytics.instance.logEvent(name: "taks_deleted");
      },
      child: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}

String taskStatus(TaskStatusMode mode) {
  switch (mode) {
    case TaskStatusMode.important:
      return '!! ';
    case TaskStatusMode.low:
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
