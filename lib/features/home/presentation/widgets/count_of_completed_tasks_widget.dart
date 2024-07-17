import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resourses/colors.dart';
import '../../bloc/task_list_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountOfCompetedTasksWidget extends StatelessWidget {
  const CountOfCompetedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 60, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).tasksDone(state.doneTasksCount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<TaskListBloc>()
                        .add(ToggleShowCompletedTasksEvent());
                  },
                  icon: Icon(
                    state.showCompletedTasks
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.lightColorBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
