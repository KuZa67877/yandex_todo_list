import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/logger.dart';
import '../../../../routes/router_delegate.dart';

class AddNewTaskItemWidget extends StatelessWidget {
  const AddNewTaskItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoRouterDelegate routerDelegate =
        Router.of(context).routerDelegate as ToDoRouterDelegate;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: InkWell(
          onTap: () async {
            logger.d('Navigating to edit task screen ');
            routerDelegate.addTask();
            //throw Exception();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Text(
                  AppLocalizations.of(context).addTaskTooltip,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    //color: AppColors.lightLabelTertiary,
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
