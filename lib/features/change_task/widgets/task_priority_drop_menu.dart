import 'package:flutter/material.dart';

import '../../../resourses/colors.dart';
import '../../../data/task.dart';

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
              taskMode = newPriority;
            }
          },
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightLabelTertiary,
          ),
          decoration: const InputDecoration(
            enabled: false,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightSupportSeparator,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
            contentPadding: EdgeInsets.only(bottom: 16.0, top: 16.0),
            labelText: 'Важность',
            labelStyle: TextStyle(
              fontSize: 22.0,
              color: AppColors.lightLabelPrimary,
            ),
          ),
          iconSize: 0,
          hint: const Text(
            'Нет',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lightLabelTertiary,
            ),
          ),
          items: const <DropdownMenuItem>[
            DropdownMenuItem(
              value: TaskStatusMode.basic,
              child: Text(
                'Нет',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightLabelPrimary,
                ),
              ),
            ),
            DropdownMenuItem(
              value: TaskStatusMode.low,
              child: Text(
                'Низкий',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightLabelPrimary,
                ),
              ),
            ),
            DropdownMenuItem(
              value: TaskStatusMode.important,
              child: Text(
                '!! Высокий',
                style: TextStyle(
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
