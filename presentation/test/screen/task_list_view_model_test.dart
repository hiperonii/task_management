import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/repository_provider.dart';
import 'package:presentation/screen/task/task_list_view_model.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:mocktail/mocktail.dart';

import '../repository_provider_mock.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

void main() {
  late TaskListViewModel sut;
  late TaskRepository taskRepository;
  late Status status;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    repositoryProvider = RepositoryProviderMock();
  });

  setUp(() {
    status = Status.todo;
    taskRepository = repositoryProvider.taskRepository;
    sut = TaskListViewModel(status, taskRepository);
  });

  test('initState() should load task list', () async {
    final task = Task('1', 'title', 'description', DateTime.now(), Status.todo);
    final pagination = TaskPagination([task], 0, 2);
    when(() => taskRepository.getTaskList(0, status)).thenAnswer((_) => Future(() => pagination));

    await sut.initState();

    expect(sut.tasksSubject, emits(pagination.tasks));
    verify(() => taskRepository.getTaskList(0, status)).called(1);
  });

  test('loadMore() should load task list', () async {
    final task1 = Task('1', 'title', 'description', DateTime.now(), Status.todo);
    final pagination1 = TaskPagination([task1], 0, 2);
    when(() => taskRepository.getTaskList(0, status)).thenAnswer((_) => Future(() => pagination1));

    await sut.initState();

    expect(sut.tasksSubject, emits(pagination1.tasks));

    final task2 = Task('1', 'title', 'description', DateTime.now(), Status.todo);
    final pagination2 = TaskPagination([task2], 1, 2);
    when(() => taskRepository.getTaskList(1, status)).thenAnswer((_) => Future(() => pagination2));

    await sut.loadMore();

    expect(sut.tasksSubject, emits(pagination1.tasks + pagination2.tasks));
  });

  test('loadMore() should not load task list if current is last page', () async {
    final task1 = Task('1', 'title', 'description', DateTime.now(), Status.todo);
    final pagination1 = TaskPagination([task1], 0, 1);
    when(() => taskRepository.getTaskList(0, status)).thenAnswer((_) => Future(() => pagination1));

    await sut.initState();

    final task2 = Task('1', 'title', 'description', DateTime.now(), Status.todo);
    final pagination2 = TaskPagination([task2], 1, 1);
    when(() => taskRepository.getTaskList(1, status)).thenAnswer((_) => Future(() => pagination2));

    await sut.loadMore();

    expect(sut.tasksSubject, emits(pagination1.tasks));
    verify(() => taskRepository.getTaskList(any(), status)).called(1);
  });

  tearDown(() {
    reset(taskRepository);
  });
}
