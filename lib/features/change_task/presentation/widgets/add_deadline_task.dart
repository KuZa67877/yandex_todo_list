import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/change_task_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDeadlineWidget extends StatefulWidget {
  bool hasDeadline;
  final DateTime? initialDate;
  AddDeadlineWidget({super.key, this.hasDeadline = false, this.initialDate});

  @override
  State<AddDeadlineWidget> createState() => _AddDeadlineWidgetState();
}

class _AddDeadlineWidgetState extends State<AddDeadlineWidget> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      helpText: DateTime.now().year.toString(),
      confirmText: AppLocalizations.of(context).done,
      cancelText: AppLocalizations.of(context).cancel,
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2077),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: false,
            dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // colorScheme: ColorScheme(
            //     onSurface: Theme.of(context).colorScheme.primary)
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.hasDeadline = true;
        context.read<ChangeTaskBloc>().add(ChangeDeadLineEvent(picked));
      });
    }
  }

  void _toggleDeadline(bool newValue) {
    setState(() {
      if (!newValue) {
        selectedDate = null;
        widget.hasDeadline = false;
        context.read<ChangeTaskBloc>().add(ChangeDeadLineEvent(DateTime.now()));
      } else {
        _selectDate(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.hasDeadline ? () => _selectDate(context) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).taskDeadline,
                  style: TextStyle(
                      //color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                if (selectedDate != null && widget.initialDate == null) ...[
                  const SizedBox(height: 8),
                  Text(
                    FormatDate.toDmmmmyyyy(selectedDate!),
                    style: const TextStyle(
                      //color: AppColors.lightColorBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                if (widget.initialDate != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    FormatDate.toDmmmmyyyy(widget.initialDate!),
                    style: const TextStyle(
                      //color: AppColors.lightColorBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]
              ],
            ),
          ),
          Theme(
            data: ThemeData(useMaterial3: false),
            child: Switch(
              value: widget.hasDeadline,
              onChanged: _toggleDeadline,
            ),
          ),
        ],
      ),
    );
  }
}

class FormatDate {
  static String toDmmmmyyyy(DateTime date) {
    return '${DateFormat.d().format(date)} ${DateFormat.MMMM('ru').format(date)} ${DateFormat.y().format(date)}';
  }
}
