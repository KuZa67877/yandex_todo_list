import 'task.dart';

abstract class TaskApi {
  const TaskApi();
  Stream<List<Task>> getTasks();
  Future<void> saveTask(Task task);
  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
  Future<int> complitedTaskCount();
  Future<void> close();
}
