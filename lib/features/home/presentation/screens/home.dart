import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resourses/colors.dart';
import '../../../../routes/router_delegate.dart';
import '../../bloc/task_list_bloc.dart';
import '../widgets/add_task_batton.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/count_of_completed_tasks_widget.dart';
import '../widgets/task_list_view.dart';

class ToDoMainScreen extends StatelessWidget {
  const ToDoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoRouterDelegate routerDelegate =
        Router.of(context).routerDelegate as ToDoRouterDelegate;

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
            key: const ValueKey('add_task_button'),
            onPressed: () {
              routerDelegate.addTask();
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
