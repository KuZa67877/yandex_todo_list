import 'package:flutter/material.dart';

class DeleteTaskButton extends StatelessWidget {
  final Color color;
  final void Function()? callback;
  DeleteTaskButton({super.key, required this.color, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Удалить",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, color: color),
            ),
          )
        ],
      ),
    );
  }
}
