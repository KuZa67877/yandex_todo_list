import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/utils/logger.dart';
import 'dart:convert';
import 'task.dart';
import 'task_api.dart';
import 'task_api_dio.dart';

class LocalStorageTaskApi extends TaskApi {
  final SharedPreferences _plugin;
  final DioTaskApi _dioTaskApi;

  LocalStorageTaskApi(
      {required SharedPreferences plugin, required DioTaskApi dioTaskApi})
      : _plugin = plugin,
        _dioTaskApi = dioTaskApi {
    _init();
  }

  late final _tasksStreamController = BehaviorSubject<List<Task>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kTasksCollectionKey = '__tasks_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  Future<void> _init() async {
    // Load tasks from local storage
    final tasksJson = _getValue(kTasksCollectionKey);
    if (tasksJson != null) {
      final tasks = List<Map<dynamic, dynamic>>.from(
        json.decode(tasksJson) as List,
      )
          .map((jsonMap) => Task.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _tasksStreamController.add(tasks);
    } else {
      _tasksStreamController.add(const []);
    }

    // Load tasks from API and save to local storage
    await for (final tasks in _dioTaskApi.getTasks()) {
      _tasksStreamController.add(tasks);
      await _setValue(kTasksCollectionKey, json.encode(tasks));
    }
  }

  @override
  Stream<List<Task>> getTasks() => _tasksStreamController.asBroadcastStream();

  @override
  Future<void> saveTask(Task task) async {
    final tasks = [..._tasksStreamController.value];
    final todoIndex = tasks.indexWhere((t) => t.UUID == task.UUID);
    if (todoIndex >= 0) {
      tasks[todoIndex] = task;
    } else {
      tasks.add(task);
    }

    _tasksStreamController.add(tasks);
    await _setValue(kTasksCollectionKey, json.encode(tasks));
    await _dioTaskApi.saveTask(task); // Save task to API
  }

  @override
  Future<void> deleteTask(String UUID) async {
    final tasks = [..._tasksStreamController.value];
    final todoIndex = tasks.indexWhere((t) => t.UUID == UUID);
    if (todoIndex == -1) {
      logger.d("Error with delete task");
    } else {
      tasks.removeAt(todoIndex);
      _tasksStreamController.add(tasks);
      await _setValue(kTasksCollectionKey, json.encode(tasks));
      await _dioTaskApi.deleteTask(UUID); // Delete task from API
    }
  }

  @override
  Future<int> complitedTaskCount() async {
    final todos = [..._tasksStreamController.value];
    final completedTodosAmount = todos.where((t) => t.isDone).length;
    todos.removeWhere((t) => t.isDone);
    _tasksStreamController.add(todos);
    await _setValue(kTasksCollectionKey, json.encode(todos));
    return completedTodosAmount;
  }

  @override
  Future<void> close() {
    return _tasksStreamController.close();
  }
}
