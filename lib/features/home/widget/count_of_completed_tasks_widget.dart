import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resourses/colors.dart';
import '../bloc/task_list_bloc.dart';
import '../bloc/task_list_event.dart';

class CountOfCompetedTasksWidget extends StatelessWidget {
  const CountOfCompetedTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskListBloc>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 60, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Выполнено — ${bloc.state.doneTasksCount}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightLabelTertiary),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<TaskListBloc>()
                    .add(ToggleShowCompletedTasksEvent());
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: AppColors.lightColorBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
