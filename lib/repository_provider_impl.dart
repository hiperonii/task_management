import 'package:domain/domain.dart';
import 'package:presentation/repository_provider.dart';
import 'package:task_management/dependency_builder.dart';

class RepositoryProviderImpl implements RepositoryProvider {
  @override
  TaskRepository get taskRepository => locator.get<TaskRepository>();
}
