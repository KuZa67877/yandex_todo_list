import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/features/change_task/change_task_screen.dart';
import 'package:yandex_to_do_app/logger/logger.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class AddNewTaskItemWidget extends StatelessWidget {
  const AddNewTaskItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () async {
          logger.d('Navigating to edit task screen ');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeTaskScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: const ListTile(
            title: Padding(
              padding: EdgeInsets.only(left: 42),
              child: Text(
                'Новое',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightLabelTertiary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
