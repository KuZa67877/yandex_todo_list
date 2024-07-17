import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/logger.dart';
import '../../resourses/colors.dart';
import '../change_task/change_task_screen.dart';
import 'bloc/task_list_bloc.dart';
import 'widget/add_task_batton.dart';
import 'widget/app_bar_widget.dart';
import 'widget/count_of_completed_tasks_widget.dart';
import 'widget/task_list_view.dart';

class ToDoMainScreen extends StatelessWidget {
  const ToDoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightBackPrimary,
          body: CustomScrollView(
            slivers: [
              const MyAppBar(),
              const CountOfCompetedTasksWidget(),
              TaskListViewWidget(tasks: state.tasksList),
              const AddNewTaskItemWidget(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addTask(context);
            },
            backgroundColor: AppColors.lightColorBlue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        );
      },
    );
  }
}

void addTask(BuildContext context) {
  logger.d('Show ChangeTaskScreen');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<TaskListBloc>(context),
        child: const ChangeTaskScreen(),
      ),
    ),
  );
}
