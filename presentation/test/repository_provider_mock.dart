import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/repository_provider.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class RepositoryProviderMock implements RepositoryProvider {
  @override
  TaskRepository get taskRepository => TaskRepositoryMock();
}
