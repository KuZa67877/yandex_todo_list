import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../utils/logger.dart';
import '../../resourses/colors.dart';
import '../../data/task.dart';
import '../home/bloc/task_list_bloc.dart';
import 'bloc/change_task_bloc.dart';
import 'widgets/add_deadline_task.dart';
import 'widgets/delete_task_button.dart';
import 'widgets/task_priority_drop_menu.dart';
import 'widgets/task_textfield.dart';

class ChangeTaskScreen extends StatefulWidget {
  final Task? task;
  const ChangeTaskScreen({super.key, this.task});

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changeTaskBloc,
      child: BlocBuilder<ChangeTaskBloc, ChangeTaskState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.lightBackPrimary,
            appBar: AppBar(
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
                    onPressed: () {
                      saveTask(context, state);
                    },
                    child: const Text(
                      "СОХРАНИТЬ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightColorBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TaskTextField(controller: _taskController),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TaskPriorityDropDownMenu(task: state.editedTask),
                ),
                AddDeadlineWidget(),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: DeleteTaskButton(
                    callback: deleteTask,
                    color: AppColors.lightColorRed,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void saveTask(BuildContext context, ChangeTaskState state) {
    final task = Task(
      UUID: widget.task?.UUID ?? const Uuid().v4(),
      taskInfo: _taskController.text,
      taskDeadline: state.editedTask?.taskDeadline,
      taskMode: state.editedTask?.taskMode ?? TaskStatusMode.standartMode,
      isDone: state.editedTask?.isDone ?? false,
    );
    context.read<TaskListBloc>().add(AddTaskEvent(task: task));
    Navigator.pop(context);
    logger.d('Current task: ${task.taskInfo}');
  }

  void deleteTask() {}
}
