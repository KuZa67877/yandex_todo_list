import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/core/data/local/local_task_data_source_impl.dart';
import 'package:yandex_to_do_app/core/domain/entities/task.dart';

//Писал эти тесты до Q&&A сессией с Глебом, решил на всякий оставить
class MockSharedPreferences implements SharedPreferences {
  final Map<String, Object> _storage = {};

  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  @override
  String? getString(String key) {
    return _storage[key] as String?;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalTaskDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalTaskDataSourceImpl(plugin: mockSharedPreferences);
  });

  group('LocalTaskDataSourceImpl', () {
    DateTime time = DateTime.now().toUtc().subtract(Duration(
        milliseconds: DateTime.now().toUtc().millisecond,
        microseconds: DateTime.now().toUtc().microsecond));

    final task = Task(createdAt: time, changedAt: time);

    Task truncateMilliseconds(Task task) {
      return task.copyWith(
        createdAt: DateTime.fromMillisecondsSinceEpoch(
                task.createdAt.millisecondsSinceEpoch,
                isUtc: true)
            .subtract(Duration(
                milliseconds: task.createdAt.millisecond,
                microseconds: task.createdAt.microsecond)),
        changedAt: DateTime.fromMillisecondsSinceEpoch(
                task.changedAt.millisecondsSinceEpoch,
                isUtc: true)
            .subtract(Duration(
                milliseconds: task.changedAt.millisecond,
                microseconds: task.changedAt.microsecond)),
      );
    }

    test('cacheTasks caches the list of tasks', () async {
      await dataSource.cacheTasks([task]);

      final cachedTasks = mockSharedPreferences
          .getString(LocalTaskDataSourceImpl.kTasksCollectionKey);
      expect(cachedTasks, isNotNull);
      final tasksList =
          List<Map<String, dynamic>>.from(json.decode(cachedTasks!));
      expect(tasksList, [task.toJson()]);
    });

    test('getCachedTasks returns a list of cached tasks', () async {
      await dataSource.cacheTasks([task]);

      final tasks = await dataSource.getCachedTasks();
      expect(tasks.map(truncateMilliseconds).toList(), [task]);
    });

    test('addTask adds a new task to the cache', () async {
      await dataSource.addTask(task);

      final tasks = await dataSource.getCachedTasks();
      expect(tasks.map(truncateMilliseconds).toList(), [task]);
    });

    test('deleteTask removes a task from the cache', () async {
      await dataSource.cacheTasks([task]);

      await dataSource.deleteTask(task.id);

      final tasks = await dataSource.getCachedTasks();
      expect(tasks, []);
    });
  });
}
