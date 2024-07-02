import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/theme/dark_theme.dart';
import 'package:yandex_to_do_app/theme/light_theme.dart';
import 'data/local_storage_task_api.dart';
import 'features/home/bloc/task_list_bloc.dart';
import 'data/task_api.dart';
import 'features/home/bloc/task_list_event.dart';
import 'features/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);
  final prefs = await SharedPreferences.getInstance();
  final taskApi = LocalStorageTaskApi(plugin: prefs);

  runApp(MyApp(taskApi: taskApi));
}

class MyApp extends StatelessWidget {
  final TaskApi taskApi;

  const MyApp({Key? key, required this.taskApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskListBloc(taskApi: taskApi)..add(LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: ToDoMainScreen(),
      ),
    );
  }
}
