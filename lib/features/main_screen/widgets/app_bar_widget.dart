import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      snap: false,
      floating: true,
      elevation: 5.0,
      collapsedHeight: 60.0,
      expandedHeight: 124.0,
      backgroundColor: AppColors.lightBackPrimary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 60.0, bottom: 17.0),
        expandedTitleScale: 1.6,
        title: Text(
          'Мои дела',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.lightLabelPrimary,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
