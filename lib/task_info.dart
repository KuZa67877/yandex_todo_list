import 'task_status.dart';

class TaskInfo {
  //TODO возможно добавить сюда сравнение классов через equatable, добавить кодировку в json
  final bool isDone;
  //final String uuid;//мб добавить uuid из pubdev для проверки уникальности таски и удаления/взаимодействия с ней
  final String taskInfo;
  final TaskStatusMode taskMode;
  final DateTime? taskDeadline; //мб поменять значение на не нуллабл
  const TaskInfo(
      {this.isDone = false,
      required this.taskInfo,
      this.taskMode = TaskStatusMode.standartMode,
      this.taskDeadline});
}
