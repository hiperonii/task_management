import 'package:collection/collection.dart';
import 'package:domain/domain.dart';
import 'package:presentation/common/extension/date_time_extension.dart';
import 'package:presentation/screen/task/model/task_item.dart';
import 'package:rxdart/rxdart.dart';

class TaskListViewModel {
  TaskListViewModel(this.status, this._taskRepository);

  final Status status;
  final TaskRepository _taskRepository;

  late final BehaviorSubject<List<Task>> tasksSubject = BehaviorSubject.seeded([]);
  late final BehaviorSubject<bool> isLoadingSubject = BehaviorSubject.seeded(false);
  late final Stream<List<TaskItem>> taskItemsStream = tasksSubject.map(_mapTaskPaginationToTaskItem);

  int _page = 0;
  bool _isLastPage = false;

  bool get _isLoading => isLoadingSubject.value;

  Future<void> initState() {
    return _getTaskList();
  }

  Future<void> loadMore() {
    if (_isLoading || _isLastPage) {
      return Future.value(null);
    }

    _page += 1;
    isLoadingSubject.add(true);
    return _getTaskList();
  }

  Future<void> _getTaskList() {
    return _taskRepository.getTaskList(_page, status).then((taskPagination) {
      _isLastPage = _page == (taskPagination.total - 1);
      tasksSubject.value += taskPagination.tasks;
    }).whenComplete(() => isLoadingSubject.add(false));
  }

  List<TaskItem> _mapTaskPaginationToTaskItem(List<Task> tasks) {
    final List<TaskItem> items = [];
    final Map<String, List<Task>> dateToTasks = groupBy(tasks, (t) => t.createdAt.format());
    dateToTasks.forEach((date, tasks) {
      items.add(HeaderTaskItem(date));
      for (var task in tasks) {
        items.add(ContentTaskItem(task.title, task.id, task.description));
      }
    });

    return items;
  }

  void onDeleteTask(String id) {
    final tasks = tasksSubject.value;
    tasks.removeWhere((t) => t.id == id);
    tasksSubject.add(tasks);
  }

  void dispose() {
    tasksSubject.close();
  }
}
