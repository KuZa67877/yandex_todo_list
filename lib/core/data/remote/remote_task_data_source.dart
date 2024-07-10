import '../../domain/entities/task.dart';

abstract class RemoteTaskDataSource {
  Stream<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> patchTasks(List<Task> tasks);
}
