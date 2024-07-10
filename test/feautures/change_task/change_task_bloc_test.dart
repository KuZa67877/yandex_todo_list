import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:yandex_to_do_app/core/domain/entities/task.dart';
import 'package:yandex_to_do_app/features/change_task/bloc/change_task_bloc.dart';

void main() {
  late ChangeTaskBloc changeTaskBloc;

  setUp(() {
    changeTaskBloc = ChangeTaskBloc();
  });

  Task roundDateTimes(Task task) {
    DateTime roundToSeconds(DateTime dateTime) =>
        DateTime.fromMillisecondsSinceEpoch(
            (dateTime.millisecondsSinceEpoch ~/ 1000) * 1000);

    return task.copyWith(
      createdAt: roundToSeconds(task.createdAt),
      changedAt: roundToSeconds(task.changedAt),
      taskDeadline:
          task.taskDeadline != null ? roundToSeconds(task.taskDeadline!) : null,
    );
  }

  DateTime roundToSeconds(DateTime dateTime) =>
      DateTime.fromMillisecondsSinceEpoch(
          (dateTime.millisecondsSinceEpoch ~/ 1000) * 1000);

  group('ChangeTaskBloc', () {
    test('initial state is ChangeTaskState()', () {
      expect(changeTaskBloc.state, ChangeTaskState());
    });

    blocTest<ChangeTaskBloc, ChangeTaskState>(
      'emits state with edited task when EditTaskEvent is added',
      build: () => changeTaskBloc,
      act: (bloc) {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        bloc.add(EditTaskEvent(task));
      },
      verify: (bloc) {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        expect(bloc.state.editedTask, task);
      },
    );

    blocTest<ChangeTaskBloc, ChangeTaskState>(
      'emits state with updated deadline when ChangeDeadLineEvent is added',
      build: () => changeTaskBloc,
      seed: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return ChangeTaskState().copyWith(editedTask: task, haveTask: true);
      },
      act: (bloc) {
        final newDeadline =
            roundToSeconds(DateTime.now().add(Duration(days: 1)));
        bloc.add(ChangeDeadLineEvent(newDeadline));
      },
      verify: (bloc) {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        final updatedTask = task.copyWith(
            taskDeadline:
                roundToSeconds(DateTime.now().add(Duration(days: 1))));
        expect(bloc.state.editedTask, roundDateTimes(updatedTask));
      },
    );

    blocTest<ChangeTaskBloc, ChangeTaskState>(
      'emits state with updated priority when ChangePriorityEvent is added',
      build: () => changeTaskBloc,
      seed: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return ChangeTaskState().copyWith(editedTask: task, haveTask: true);
      },
      act: (bloc) {
        bloc.add(ChangePriorityEvent(TaskStatusMode.important));
      },
      verify: (bloc) {
        final task =
            roundDateTimes(Task(id: '1', taskInfo: 'test task', done: false));
        final updatedTask = task.copyWith(taskMode: TaskStatusMode.important);
        expect(bloc.state.editedTask, roundDateTimes(updatedTask));
      },
    );
  });
}
