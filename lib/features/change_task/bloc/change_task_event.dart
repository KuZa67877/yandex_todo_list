part of 'change_task_bloc.dart';

abstract class ChangeTaskEvent {
  const ChangeTaskEvent();
}

class EditTaskEvent extends ChangeTaskEvent {
  final Task task;
  const EditTaskEvent(this.task);
}

class ChangeDeadLineEvent extends ChangeTaskEvent {
  final DateTime deadline;
  const ChangeDeadLineEvent(this.deadline);
}

class DeleteCurrentTaskEvent extends ChangeTaskEvent {
  final String id;
  const DeleteCurrentTaskEvent(this.id);
}

class ChangePriorityEvent extends ChangeTaskEvent {
  final TaskStatusMode priority;
  const ChangePriorityEvent(this.priority);
}
