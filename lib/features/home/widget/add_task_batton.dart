import 'package:flutter/material.dart';

import '../../../utils/logger.dart';
import '../../../resourses/colors.dart';
import '../../change_task/change_task_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTaskItemWidget extends StatelessWidget {
  const AddNewTaskItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () async {
            logger.d('Navigating to edit task screen ');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangeTaskScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Text(
                  AppLocalizations.of(context).addTaskTooltip,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightLabelTertiary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
