import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key});

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
          width: 328,
          height: 104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                //offset: Offset(0, 1),
              ),
            ],
          ),
          child: const TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Что надо сделать...",
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightLabelTertiary)),
          )),
    );
  }
}
