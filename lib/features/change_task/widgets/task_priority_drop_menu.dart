import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resourses/colors.dart';
import '../../../data/task.dart';
import '../bloc/change_task_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskPriorityDropDownMenu extends StatelessWidget {
  final Task? task;
  const TaskPriorityDropDownMenu({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    TaskStatusMode taskMode = task?.taskMode ?? TaskStatusMode.basic;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ButtonTheme(
        child: DropdownButtonFormField(
          value: taskMode,
          onChanged: (newPriority) {
            if (newPriority != taskMode) {
              context
                  .read<ChangeTaskBloc>()
                  .add(ChangePriorityEvent(newPriority!));
            }
          },
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightLabelTertiary,
          ),
          decoration: InputDecoration(
            enabled: false,
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightSupportSeparator,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
            contentPadding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            labelText: AppLocalizations.of(context).taskImportance,
            labelStyle: const TextStyle(
              fontSize: 22.0,
              color: AppColors.lightLabelPrimary,
            ),
          ),
          iconSize: 0,
          hint: Text(
            AppLocalizations.of(context).taskImportanceBasic,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.lightLabelTertiary,
            ),
          ),
          items: <DropdownMenuItem>[
            DropdownMenuItem(
              value: TaskStatusMode.basic,
              child: Text(
                AppLocalizations.of(context).taskImportanceBasic,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.lightLabelPrimary,
                ),
              ),
            ),
            DropdownMenuItem(
              value: TaskStatusMode.low,
              child: Text(
                AppLocalizations.of(context).taskImportanceLow,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.lightLabelPrimary,
                ),
              ),
            ),
            DropdownMenuItem(
              value: TaskStatusMode.important,
              child: Text(
                AppLocalizations.of(context).taskImportanceImportant,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.lightColorRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
