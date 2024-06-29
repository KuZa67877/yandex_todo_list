import 'task.dart';

abstract class TaskApi {
  const TaskApi();
  Stream<List<Task>> getTasks();
  Future<void> saveTask(Task task);
  Future<void> deleteTask(String UUID);
  Future<int> complitedTaskCount();
  Future<void> close();
}