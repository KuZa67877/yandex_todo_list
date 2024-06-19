import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class TaskPriorityDropDownMenu extends StatefulWidget {
  const TaskPriorityDropDownMenu({super.key});

  @override
  _TaskPriorityDropDownMenuState createState() =>
      _TaskPriorityDropDownMenuState();
}

class _TaskPriorityDropDownMenuState extends State<TaskPriorityDropDownMenu> {
  String _selectedValue = "Нет";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedValue,
      items: [
        DropdownMenuItem(
          value: "Нет",
          child: Text("Нет", style: TextStyle(fontWeight: FontWeight.w400)),
        ),
        DropdownMenuItem(
          value: "Низкий",
          child: Text(
            "Низкий",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        DropdownMenuItem(
          value: "!! Высокий",
          child: Text(
            "!! Высокий",
            style: TextStyle(
                color: AppColors.lightColorRed, fontWeight: FontWeight.w400),
          ),
        ),
      ],
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedValue = newValue;
          });
        }
      },
    );
  }
}
