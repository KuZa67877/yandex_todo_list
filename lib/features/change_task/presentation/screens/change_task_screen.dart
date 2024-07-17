import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/resourses/colors.dart';
import '../../../../core/domain/entities/task.dart';
import '../../../home/bloc/task_list_bloc.dart';
import '../../bloc/change_task_bloc.dart';
import '../widgets/add_deadline_task.dart';
import '../widgets/delete_task_button.dart';
import '../widgets/task_priority_drop_menu.dart';
import '../widgets/task_textfield.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeTaskScreen extends StatefulWidget {
  final Task? task;
  const ChangeTaskScreen(
      {super.key = const ValueKey("change_task_screen"), this.task});

  @override
  State<ChangeTaskScreen> createState() => _ChangeTaskScreenState();
}

class _ChangeTaskScreenState extends State<ChangeTaskScreen> {
  late final ChangeTaskBloc _changeTaskBloc;
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _changeTaskBloc = ChangeTaskBloc();
    if (widget.task != null) {
      _taskController.text = widget.task!.taskInfo;
      _changeTaskBloc.add(EditTaskEvent(widget.task!));
    } else {
      _changeTaskBloc.add(EditTaskEvent(Task(
        id: const Uuid().v4(),
        taskInfo: '',
        taskDeadline: null,
        taskMode: TaskStatusMode.basic,
        done: false,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _changeTaskBloc,
      child: BlocBuilder<ChangeTaskBloc, ChangeTaskState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(
                onPressed: () {
                  logger.d('Back to main Screen');
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TextButton(
                    key: const ValueKey("save_task"),
                    onPressed: () {
                      saveTask(context, state);
                    },
                    child: Text(
                      AppLocalizations.of(context).save,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightColorBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TaskTextField(
                          controller: _taskController,
                          key: const ValueKey("text_field")),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TaskPriorityDropDownMenu(task: state.editedTask),
                  ),
                  AddDeadlineWidget(
                    hasDeadline: state.editedTask?.taskDeadline != null,
                    initialDate: state.editedTask?.taskDeadline,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DeleteTaskButton(
                      callback: () => deleteTask(),
                      color: AppColors.lightColorRed,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void saveTask(BuildContext context, ChangeTaskState state) async {
    final task = Task(
      id: widget.task?.id ?? const Uuid().v4(),
      taskInfo: _taskController.text,
      taskDeadline: state.editedTask?.taskDeadline,
      taskMode: state.editedTask?.taskMode ?? TaskStatusMode.basic,
      done: state.editedTask?.done ?? false,
    );
    if (widget.task == null) {
      context.read<TaskListBloc>().add(AddTaskEvent(task: task));

      await FirebaseAnalytics.instance.logEvent(name: "taks_added");
    } else {
      context
          .read<TaskListBloc>()
          .add(ChangeTaskStatusEvent(task: task, isDone: task.done));

      await FirebaseAnalytics.instance.logEvent(name: "tak_changed");
    }
    Navigator.pop(context);
    logger.d('Current task: ${task.taskInfo}');

    await FirebaseAnalytics.instance.logEvent(name: "back_to_main_screen");
  }

  void deleteTask() async {
    if (widget.task != null) {
      context.read<TaskListBloc>().add(DeleteTaskEvent(task: widget.task!));

      await FirebaseAnalytics.instance.logEvent(name: "taks_deleted");
    }

    Navigator.pop(context);
    await FirebaseAnalytics.instance.logEvent(name: "back_to_main_screen");
  }
}
