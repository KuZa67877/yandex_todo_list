import 'package:flutter/material.dart';
import 'package:yandex_to_do_app/resourses/colors.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: AppColors.lightBackPrimary,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Мои Дела'),
      ),
      // Убираем иконку из AppBar
      actions: [],
    );
  }
}
