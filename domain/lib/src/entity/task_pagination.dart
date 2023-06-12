import 'package:domain/domain.dart';

class TaskPagination {
  TaskPagination(this.tasks, this.page, this.total);

  final List<Task> tasks;
  final int page;
  final int total;
}
