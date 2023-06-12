import 'package:domain/domain.dart';

late RepositoryProvider repositoryProvider;

abstract class RepositoryProvider {
  TaskRepository get taskRepository;
}
