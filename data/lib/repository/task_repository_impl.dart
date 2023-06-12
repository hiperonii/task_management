import 'package:data/api_service/task_api_service.dart';
import 'package:data/repository/task_mapper.dart';
import 'package:domain/domain.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._taskApiService, this._taskMapper);

  static const int _pageSize = 10;
  static const String _sortBy = 'createAt';
  static const bool _isAscending = true;

  final TaskApiService _taskApiService;
  final TaskMapper _taskMapper;

  @override
  Future<TaskPagination> getTaskList(int page, Status status) {
    return _taskApiService
        .getTodoList(page, _pageSize, _sortBy, _isAscending, status.name)
        .then((dto) => _taskMapper.mapTaskResponseToTaskPagination(dto));
  }
}
