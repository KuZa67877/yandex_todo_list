import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';
import 'package:yandex_to_do_app/widgets/change_task/task_priority_drop_menu.dart';
import 'package:yandex_to_do_app/widgets/change_task/task_textfield.dart';

class ChangeTaskScreen extends StatefulWidget {
  const ChangeTaskScreen({super.key});

  @override
  State<ChangeTaskScreen> createState() => _ChangeTaskScreenState();
}

class _ChangeTaskScreenState extends State<ChangeTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            returnBack(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "СОХРАНИТЬ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightColorBlue),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.center, child: TaskTextField()),
          ),
          TaskPriorityDropDownMenu()
        ],
      ),
    );
  }
}

void returnBack(BuildContext context) {
  Navigator.pop(context);
}
