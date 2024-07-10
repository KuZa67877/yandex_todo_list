import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:yandex_to_do_app/core/domain/entities/task.dart';
import 'package:yandex_to_do_app/core/domain/repository/task_repository.dart';
import 'package:yandex_to_do_app/features/home/bloc/task_list_bloc.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class FakeTask extends Fake implements Task {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskListBloc taskListBloc;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskListBloc = TaskListBloc(taskRepository: mockTaskRepository);
    registerFallbackValue(FakeTask());
  });

  Task roundDateTimes(Task task) {
    DateTime roundToSeconds(DateTime dateTime) =>
        DateTime.fromMillisecondsSinceEpoch(
            (dateTime.millisecondsSinceEpoch ~/ 1000) * 1000);

    return task.copyWith(
      createdAt: roundToSeconds(task.createdAt),
      changedAt: roundToSeconds(task.changedAt),
    );
  }

  group('TaskListBloc', () {
    test('initial state is TaskListState.initial()', () {
      expect(taskListBloc.state, TaskListState.initial());
    });

    blocTest<TaskListBloc, TaskListState>(
      'emits tasks loaded state when LoadTasksEvent is added',
      build: () {
        when(() => mockTaskRepository.getTasks()).thenAnswer(
          (_) async => [
            roundDateTimes(Task(id: '1', taskInfo: 'test task')),
          ],
        );
        return taskListBloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return [
          TaskListState.initial().copyWith(
            tasksList: [task],
            doneTasksCount: 0,
          ),
        ];
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'adds task and reloads tasks when AddTaskEvent is added',
      build: () {
        when(() => mockTaskRepository.addTask(any())).thenAnswer((_) async {});
        when(() => mockTaskRepository.getTasks()).thenAnswer(
          (_) async => [
            roundDateTimes(Task(id: '1', taskInfo: 'test task')),
          ],
        );
        return taskListBloc;
      },
      act: (bloc) => bloc.add(AddTaskEvent(
          task: roundDateTimes(Task(id: '1', taskInfo: 'test task')))),
      expect: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return [
          TaskListState.initial().copyWith(
            tasksList: [task],
            doneTasksCount: 0,
          ),
        ];
      },
      verify: (_) {
        verify(() => mockTaskRepository.addTask(any())).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'updates task status when ChangeTaskStatusEvent is added',
      build: () {
        when(() => mockTaskRepository.updateTask(any()))
            .thenAnswer((_) async {});
        return taskListBloc;
      },
      seed: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return TaskListState.initial().copyWith(
          tasksList: [task],
        );
      },
      act: (bloc) => bloc.add(ChangeTaskStatusEvent(
          task: roundDateTimes(Task(id: '1', taskInfo: 'test task')),
          isDone: true)),
      expect: () {
        final task =
            roundDateTimes(Task(id: '1', taskInfo: 'test task', done: true));
        return [
          TaskListState.initial().copyWith(
            tasksList: [task],
            doneTasksCount: 1,
          ),
        ];
      },
      verify: (_) {
        verify(() => mockTaskRepository.updateTask(any())).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'deletes task when DeleteTaskEvent is added',
      build: () {
        when(() => mockTaskRepository.deleteTask(any()))
            .thenAnswer((_) async {});
        return taskListBloc;
      },
      seed: () {
        final task = roundDateTimes(Task(id: '1', taskInfo: 'test task'));
        return TaskListState.initial().copyWith(
          tasksList: [task],
        );
      },
      act: (bloc) => bloc.add(DeleteTaskEvent(
          task: roundDateTimes(Task(id: '1', taskInfo: 'test task')))),
      expect: () => [
        TaskListState.initial().copyWith(
          tasksList: [],
          doneTasksCount: 0,
        ),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.deleteTask(any())).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'toggles show completed tasks when ToggleShowCompletedTasksEvent is added',
      build: () => taskListBloc,
      act: (bloc) => bloc.add(ToggleShowCompletedTasksEvent()),
      expect: () => [
        TaskListState.initial().copyWith(showCompletedTasks: true),
      ],
    );
  });
}
