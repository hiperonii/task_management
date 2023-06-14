import 'package:flutter/material.dart';
import 'package:presentation/screen/task/model/task_item.dart';
import 'package:presentation/screen/task/widget/content_item_widget.dart';
import 'package:presentation/screen/task/widget/header_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget(
    this._tasks, {
    super.key,
    this.onLoadMore,
    this.onDeleteItem,
  });

  final List<TaskItem> _tasks;
  final VoidCallback? onLoadMore;
  final ValueChanged<String>? onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 60),
        itemCount: _tasks.length,
        itemBuilder: (_, index) {
          return _buildItem(_tasks[index]);
        },
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.metrics.pixels > notification.metrics.maxScrollExtent * 0.9) {
      onLoadMore?.call();
    }

    return true;
  }

  Widget _buildItem(TaskItem item) {
    if (item is HeaderTaskItem) {
      return HeaderItemWidget(item);
    } else if (item is ContentTaskItem) {
      return ContentItemWidget(
        item,
        key: ValueKey(item.id),
        onDelete: () => onDeleteItem?.call(item.id),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
