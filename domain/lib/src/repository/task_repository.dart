import 'package:domain/domain.dart';

abstract class TaskRepository {
  Future<TaskPagination> getTaskList(int page, Status status);
}
