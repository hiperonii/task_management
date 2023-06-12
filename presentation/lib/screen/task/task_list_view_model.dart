import 'package:collection/collection.dart';
import 'package:domain/domain.dart';
import 'package:presentation/extension/date_time_extension.dart';
import 'package:presentation/repository_provider.dart';
import 'package:presentation/screen/task/model/task_item.dart';
import 'package:rxdart/rxdart.dart';

class TaskListViewModel {
  TaskListViewModel(this.status);

  final Status status;

  late final TaskRepository _taskRepository = repositoryProvider.taskRepository;
  late final BehaviorSubject<List<Task>> tasksSubject = BehaviorSubject.seeded([]);
  late final Stream<List<TaskItem>> taskItemsStream = tasksSubject.map(_mapTaskPaginationToTaskItem);
  late final LoadingTaskItem _loadingItem = const LoadingTaskItem();

  int _page = 0;
  bool _isLoading = false;
  bool _isLastPage = false;

  void initState() {
    _getTaskList();
  }

  void loadMore() {
    if (_isLoading || _isLastPage) {
      return;
    }

    _page += 1;
    _isLoading = true;
    _getTaskList();
  }

  void _getTaskList() {
    _taskRepository.getTaskList(_page, status).then((taskPagination) {
      _isLastPage = _page == (taskPagination.total - 1);
      tasksSubject.value += taskPagination.tasks;
    }).whenComplete(() => _isLoading = false);
  }

  List<TaskItem> _mapTaskPaginationToTaskItem(List<Task> tasks) {
    final List<TaskItem> items = [];
    final Map<String, List<Task>> dateToTasks = groupBy(tasks, (t) => t.createdAt.format());
    dateToTasks.forEach((date, tasks) {
      items.add(HeaderTaskItem(date));
      for (var task in tasks) {
        items.add(ContentTaskItem(task.title, task.description));
      }
    });

    return items;
  }

  void dispose() {
    tasksSubject.close();
  }
}
