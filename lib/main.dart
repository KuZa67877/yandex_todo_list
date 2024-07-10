import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/core/theme/dark_theme.dart';
import 'package:yandex_to_do_app/core/theme/light_theme.dart';
import 'core/data/local/local_task_data_source_impl.dart';
import 'core/data/remote/remote_task_data_source_impl.dart';
import 'core/domain/repository/task_repository.dart';
import 'core/domain/repository/task_repository_impl.dart';
import 'features/home/bloc/task_list_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'l10n/l10n.dart';
import 'routes/route_information_parser.dart';
import 'routes/router_delegate.dart';

final GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);

  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  final localDataSource = LocalTaskDataSourceImpl(plugin: prefs);
  final remoteDataSource = RemoteTaskDataSourceImpl(
    baseUrl: 'https://beta.mrdekk.ru/todo',
    authToken: '${dotenv.env["TOKEN"]}',
  );
  final TaskRepository repository = TaskRepositoryImpl(
      localDataSource: localDataSource, remoteDataSource: remoteDataSource);
  getIt.registerSingleton<TaskRepository>(repository);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ToDoRouterDelegate routerDelegate = ToDoRouterDelegate();
    final ToDoRouteInformationParser routeInformationParser =
        ToDoRouteInformationParser();

    return BlocProvider(
      create: (context) =>
          TaskListBloc(taskRepository: getIt<TaskRepository>()),
      child: MaterialApp.router(
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
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
      ),
    );
  }
}
