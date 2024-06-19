import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_to_do_app/bloc/task_list/task_list_bloc.dart';
import 'package:yandex_to_do_app/bloc/task_list/task_list_info.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';
import 'package:yandex_to_do_app/widgets/app_bar_widget.dart';
import 'package:yandex_to_do_app/widgets/change_task/change_task_screen.dart';
import 'package:yandex_to_do_app/widgets/count_of_completed_tasks_widget.dart';

class ToDoMainScreen extends StatefulWidget {
  const ToDoMainScreen({super.key});

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
                  child: Card(
                    //child: TaskListView(),
                    color: AppColors.lightBackPrimary,
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addTask(context);
              },
              child: Icon(
                Icons.add,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              backgroundColor: AppColors.lightColorBlue,
              shape: CircleBorder(),
            ),
          );
        },
      ),
    );
  }
}

void addTask(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ChangeTaskScreen()));
}
