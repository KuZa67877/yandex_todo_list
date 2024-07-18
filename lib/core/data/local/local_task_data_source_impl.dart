import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/task.dart';
import 'local_task_data_source.dart';

class LocalTaskDataSourceImpl implements LocalTaskDataSource {
  final SharedPreferences _plugin;
  static const String kTasksCollectionKey = '__tasks_collection_key__';

  LocalTaskDataSourceImpl({required SharedPreferences plugin})
      : _plugin = plugin;

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  @override
  Future<void> cacheTasks(List<Task> tasks) async {
    await _setValue(kTasksCollectionKey,
        json.encode(tasks.map((task) => task.toJson()).toList()));
  }

  @override
  Future<List<Task>> getCachedTasks() async {
    final tasksJson = _getValue(kTasksCollectionKey);
    if (tasksJson != null) {
      final tasks = List<Map<dynamic, dynamic>>.from(
              json.decode(tasksJson) as List)
          .map((jsonMap) => Task.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      return tasks;
    } else {
      return [];
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = await getCachedTasks();
    tasks.add(task);
    await cacheTasks(tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = await getCachedTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await cacheTasks(tasks);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final tasks = await getCachedTasks();
    tasks.removeWhere((task) => task.id == id);
    await cacheTasks(tasks);
  }
}
