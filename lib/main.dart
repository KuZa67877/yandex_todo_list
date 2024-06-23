import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_to_do_app/features/change_task/bloc/change_task_bloc.dart';
import 'package:yandex_to_do_app/features/main_screen/bloc/task_list_bloc.dart';
import 'package:yandex_to_do_app/features/main_screen/main_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<TaskListBloc>(create: (context) => TaskListBloc()),
    BlocProvider<ChangeTaskBloc>(create: (context) => ChangeTaskBloc())
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
