import 'package:yandex_to_do_app/features/main_screen/bloc/task_info.dart';

abstract class ChangeTaskEvent {
  const ChangeTaskEvent();
}

class EditTaskEvent extends ChangeTaskEvent {
  final TaskInfo task;
  const EditTaskEvent(this.task);
}

class ChangeDeadLineEvent extends ChangeTaskEvent {
  final DateTime deadline;
  const ChangeDeadLineEvent(this.deadline);
}

class DeleteCurrentTaskEvent extends ChangeTaskEvent {
  final String UUID;
  const DeleteCurrentTaskEvent(this.UUID);
}
