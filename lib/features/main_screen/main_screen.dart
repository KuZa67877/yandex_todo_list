import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_bloc.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_info.dart';
import 'package:yandex_to_do_app/features/main_screen/widgets/task_list_view.dart';
import 'package:yandex_to_do_app/logger/logger.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';
import 'package:yandex_to_do_app/features/main_screen/widgets/app_bar_widget.dart';
import 'package:yandex_to_do_app/features/change_task/change_task_screen.dart';
import 'package:yandex_to_do_app/features/main_screen/widgets/count_of_completed_tasks_widget.dart';

class ToDoMainScreen extends StatefulWidget {
  const ToDoMainScreen({Key? key}) : super(key: key);

  @override
  State<ToDoMainScreen> createState() => _ToDoMainScreenState();
}

class _ToDoMainScreenState extends State<ToDoMainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskListBloc>(
      create: (context) => TaskListBloc(),
      child: BlocBuilder<TaskListBloc, TaskListInfo>(
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: AppColors.lightBackPrimary,
            body: CustomScrollView(
              slivers: [
                MyAppBar(),
                CountOfCompetedTasksWidget(),
                SliverToBoxAdapter(
                  child: TaskListViewWidget(tasks: state.tasksList),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addTask(context);
              },
              backgroundColor: AppColors.lightColorBlue,
              shape: CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          );
        },
      ),
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
        child: ChangeTaskScreen(),
      ),
    ),
  );
}
