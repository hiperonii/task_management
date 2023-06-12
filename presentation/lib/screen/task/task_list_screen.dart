import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/screen/task/model/task_item.dart';
import 'package:presentation/screen/task/task_list_view_model.dart';
import 'package:presentation/screen/task/widget/content_item_widget.dart';
import 'package:presentation/screen/task/widget/header_item_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen(this.status, {super.key});

  final Status status;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with AutomaticKeepAliveClientMixin {
  late final TaskListViewModel _viewModel = TaskListViewModel(widget.status);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<TaskItem>>(
        stream: _viewModel.taskItemsStream,
        builder: (_, snapshot) {
          final tasks = snapshot.data ?? [];
          return NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 60),
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                return _buildItem(tasks[index]);
              },
            ),
          );
        });
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.metrics.pixels > notification.metrics.maxScrollExtent * 0.9) {
      _viewModel.loadMore();
    }

    return true;
  }

  Widget _buildItem(TaskItem item) {
    if (item is HeaderTaskItem) {
      return HeaderItemWidget(item);
    } else if (item is ContentTaskItem) {
      return ContentItemWidget(item);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
