import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yandex_to_do_app/core/theme/dark_theme.dart';
import 'package:yandex_to_do_app/core/theme/light_theme.dart';
import 'package:yandex_to_do_app/core/utils/logger.dart';
import 'core/data/di.dart';
import 'core/domain/repository/task_repository.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'routes/route_information_parser.dart';
import 'routes/router_delegate.dart';
import 'features/home/bloc/task_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  logger.d(app.options.projectId);

  await initializeDateFormatting('ru', null);

  await ServiceLocator.setup();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
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
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    return BlocProvider(
      create: (context) =>
          TaskListBloc(taskRepository: ServiceLocator.getIt<TaskRepository>()),
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
