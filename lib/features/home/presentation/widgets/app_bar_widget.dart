import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context).appTitle,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
      ),
    );
  }
}
