import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: AppColors.lightBackPrimary,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Мои Дела',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
      ),
      actions: [],
    );
  }
}
