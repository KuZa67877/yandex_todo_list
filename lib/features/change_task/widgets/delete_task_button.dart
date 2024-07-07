import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteTaskButton extends StatelessWidget {
  final Color color;
  final void Function() callback;
  const DeleteTaskButton(
      {super.key, required this.color, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              AppLocalizations.of(context).remove,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, color: color),
            ),
          )
        ],
      ),
    );
  }
}
