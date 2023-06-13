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
    return StreamBuilder<bool>(
        stream: _viewModel.isLoadingSubject,
        builder: (_, snapshot) {
          final isLoading = snapshot.data ?? false;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                child: StreamBuilder<List<TaskItem>>(
                    stream: _viewModel.taskItemsStream,
                    builder: (_, snapshot) {
                      final tasks = snapshot.data ?? [];
                      return NotificationListener<ScrollNotification>(
                        onNotification: _onNotification,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 60),
                          itemCount: tasks.length,
                          itemBuilder: (_, index) {
                            return _buildItem(tasks[index]);
                          },
                        ),
                      );
                    }),
              ),
              if (isLoading)
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(bottom: 24),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
            ],
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
      return ContentItemWidget(
        item,
        key: Key(item.id),
        onDelete: () => _viewModel.onDeleteTask(item.id),
      );
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
