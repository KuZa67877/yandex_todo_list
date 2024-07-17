import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/l10n/l10n.dart';
import 'package:yandex_to_do_app/theme/dark_theme.dart';
import 'package:yandex_to_do_app/theme/light_theme.dart';
import 'data/local_storage_task_api.dart';
import 'data/task_api_dio.dart';
import 'features/home/bloc/task_list_bloc.dart';
import 'data/task_api.dart';
import 'features/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);
  final prefs = await SharedPreferences.getInstance();

  final dioTaskApi =
      DioTaskApi(baseUrl: 'https://beta.mrdekk.ru/todo', authToken: 'Tulkas');

  final taskApi = LocalStorageTaskApi(plugin: prefs, dioTaskApi: dioTaskApi);

  runApp(MyApp(taskApi: taskApi));
}

class MyApp extends StatelessWidget {
  final TaskApi taskApi;

  const MyApp({super.key, required this.taskApi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskListBloc(taskApi: taskApi)..add(LoadTasksEvent()),
      child: MaterialApp(
        supportedLocales: L10n.all,
        locale: const Locale("ru"),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: ToDoMainScreen(),
      ),
    );
  }
}
