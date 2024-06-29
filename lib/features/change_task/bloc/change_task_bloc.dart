import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/task.dart';

part 'change_task_event.dart';
part 'change_task_state.dart';

class ChangeTaskBloc extends Bloc<ChangeTaskEvent, ChangeTaskState> {
  ChangeTaskBloc() : super(ChangeTaskState()) {
    on<EditTaskEvent>(_editTask);
    on<DeleteCurrentTaskEvent>(_deleteCurrentTask);
    on<ChangeDeadLineEvent>(_changeDeadLine);
  }

  Future<void> _editTask(
      EditTaskEvent event, Emitter<ChangeTaskState> emit) async {
    emit(state.copyWith(editedTask: event.task, haveTask: true));
  }

  Future<void> _deleteCurrentTask(
      DeleteCurrentTaskEvent event, Emitter<ChangeTaskState> emit) async {
    emit(state.copyWith(editedTask: null, haveTask: false));
  }

  Future<void> _changeDeadLine(
      ChangeDeadLineEvent event, Emitter<ChangeTaskState> emit) async {
    if (state.editedTask != null) {
      final updatedTask =
          state.editedTask!.copyWith(taskDeadline: event.deadline);
      emit(state.copyWith(editedTask: updatedTask));
    }
  }
}
