import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yandex_to_do_app/core/data/local/local_task_data_source.dart';
import 'package:yandex_to_do_app/core/data/remote/remote_task_data_source.dart';
import 'package:yandex_to_do_app/core/domain/entities/task.dart';
import 'package:yandex_to_do_app/core/utils/logger.dart';

import 'task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final LocalTaskDataSource localDataSource;
  final RemoteTaskDataSource remoteDataSource;

  TaskRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  }) {
    _init();
  }

  Future<void> _init() async {
    await _syncLocalToRemote();
  }

  Future<void> _syncLocalToRemote() async {
    final result = await Connectivity().checkConnectivity();
    final status = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
    if (status) {
      try {
        final localTasks = await localDataSource.getCachedTasks();
        await remoteDataSource.patchTasks(localTasks);
      } catch (e) {
        logger.e("Failed to sync tasks to remote: $e");
      }
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    try {
      final remoteTasks = await remoteDataSource.getTasks().first;
      await localDataSource.cacheTasks(remoteTasks);
      return remoteTasks;
    } catch (e) {
      return await localDataSource.getCachedTasks();
    }
  }

  @override
  Future<void> addTask(Task task) async {
    try {
      await localDataSource.addTask(task);
      await _syncLocalToRemote();
    } catch (e) {
      logger.e("Failed to add task: $e");
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      await localDataSource.updateTask(task);
      await _syncLocalToRemote();
    } catch (e) {
      logger.e("Failed to update task: $e");
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      await _syncLocalToRemote();
    } catch (e) {
      logger.e("Failed to delete task: $e");
    }
  }

  @override
  Future<void> patchTasks(List<Task> tasks) async {
    try {
      await remoteDataSource.patchTasks(tasks);
    } catch (e) {
      logger.e("Failed to patch tasks: $e");
    }
  }
}
