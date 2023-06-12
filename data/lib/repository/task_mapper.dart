import 'package:data/dto/task_dto.dart';
import 'package:data/dto/task_response.dart';
import 'package:domain/domain.dart';

class TaskMapper {
  TaskPagination mapTaskResponseToTaskPagination(TaskResponse dto) {
    return TaskPagination(
      _mapTaskDtoListToTaskList(dto.tasks),
      dto.pageNumber,
      dto.totalPages,
    );
  }

  List<Task> _mapTaskDtoListToTaskList(List<TaskDto> dtos) {
    return dtos.map((dto) => _mapTaskDtoToTask(dto)).toList();
  }

  Task _mapTaskDtoToTask(TaskDto dto) {
    final status = Status.values.firstWhere((it) => it.name == dto.status);
    final date = DateTime.parse(dto.createdAt).toLocal();
    return Task(dto.id, dto.title, dto.description, date, status);
  }
}
