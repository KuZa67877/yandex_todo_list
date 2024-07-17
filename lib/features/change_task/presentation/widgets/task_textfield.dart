import 'package:flutter/material.dart';
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
    // Получаем цвет из темы
    final inputBackgroundColor =
        Theme.of(context).inputDecorationTheme.fillColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 104,
        ),
        decoration: BoxDecoration(
          color: inputBackgroundColor, // Используем цвет фона из темы
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
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
            hintText: AppLocalizations.of(context).taskTextHint,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: inputBackgroundColor, // Используем тот же цвет фона
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none, // Убираем рамку
            ),
          ),
        ),
      ),
    );
  }
}
