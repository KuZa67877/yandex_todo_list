import '../../domain/entities/task.dart';

abstract class LocalTaskDataSource {
  Future<void> cacheTasks(List<Task> tasks);
  Future<List<Task>> getCachedTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}
