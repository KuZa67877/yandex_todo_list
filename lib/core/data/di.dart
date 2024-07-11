import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../domain/repository/task_repository.dart';
import '../domain/repository/task_repository_impl.dart';
import 'local/local_task_data_source_impl.dart';
import 'remote/remote_task_data_source_impl.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    await dotenv.load(fileName: ".env");

    final prefs = await SharedPreferences.getInstance();
    final localDataSource = LocalTaskDataSourceImpl(plugin: prefs);

    final remoteDataSource = RemoteTaskDataSourceImpl(
      baseUrl: 'https://beta.mrdekk.ru/todo',
      authToken: '${dotenv.env["TOKEN"]}',
    );

    final TaskRepository repository = TaskRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );

    getIt.registerSingleton<TaskRepository>(repository);
  }
}
