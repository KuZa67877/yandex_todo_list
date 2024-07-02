import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import '../utils/logger.dart';
import 'task.dart';
import 'task_api.dart';
import 'task_api_dio.dart';

class LocalStorageTaskApi extends TaskApi {
  final SharedPreferences _plugin;
  final DioTaskApi _dioTaskApi;
  static const String _tasksLoadedFromApiKey = '_tasks_loaded_from_api';

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

  Future<void> _setBoolValue(String key, bool value) =>
      _plugin.setBool(key, value);

  bool _getBoolValue(String key) => _plugin.getBool(key) ?? false;

  Future<void> _init() async {
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
    await _loadTasksFromApi();
  }

  Future<void> _loadTasksFromApi() async {
    final tasks = await _dioTaskApi.getTasks().first;
    final allTasks = [
      ..._tasksStreamController.value,
      if (_getBoolValue(_tasksLoadedFromApiKey) == false) ...tasks
    ];
    _tasksStreamController.add(allTasks);
    await _setValue(kTasksCollectionKey,
        json.encode(allTasks.map((task) => task.toJson()).toList()));
    await _setBoolValue(_tasksLoadedFromApiKey, true);
  }

  @override
  Stream<List<Task>> getTasks() => _tasksStreamController.asBroadcastStream();

  @override
  Future<void> saveTask(Task task) async {
    final tasks = [..._tasksStreamController.value];
    final todoIndex = tasks.indexWhere((t) => t.id == task.id);
    if (todoIndex >= 0) {
      tasks[todoIndex] = task;
    } else {
      tasks.add(task);
    }

    _tasksStreamController.add(tasks);
    await _setValue(kTasksCollectionKey,
        json.encode(tasks.map((task) => task.toJson()).toList()));
    await _dioTaskApi.saveTask(task);
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = [..._tasksStreamController.value];
    tasks.add(task);

    _tasksStreamController.add(tasks);
    await _setValue(kTasksCollectionKey,
        json.encode(tasks.map((task) => task.toJson()).toList()));
    await _dioTaskApi.addTask(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    final tasks = [..._tasksStreamController.value];
    final todoIndex = tasks.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      logger.d("Error with delete task");
    } else {
      tasks.removeAt(todoIndex);
      _tasksStreamController.add(tasks);
      await _setValue(kTasksCollectionKey,
          json.encode(tasks.map((task) => task.toJson()).toList()));
      await _dioTaskApi.deleteTask(id);
    }
  }

  @override
  Future<int> complitedTaskCount() async {
    final todos = [..._tasksStreamController.value];
    final completedTodosAmount = todos.where((t) => t.done).length;
    todos.removeWhere((t) => t.done);
    _tasksStreamController.add(todos);
    await _setValue(kTasksCollectionKey,
        json.encode(todos.map((task) => task.toJson()).toList()));
    return completedTodosAmount;
  }

  @override
  Future<void> close() {
    return _tasksStreamController.close();
  }
}
