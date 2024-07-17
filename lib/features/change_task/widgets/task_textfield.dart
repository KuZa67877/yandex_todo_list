import 'package:flutter/material.dart';

import '../../../resourses/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 104,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            border: InputBorder.none,
            hintText: AppLocalizations.of(context).taskTextHint,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.lightLabelTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
