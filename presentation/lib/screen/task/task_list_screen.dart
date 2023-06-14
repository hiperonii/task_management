import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/widgets/loading.dart';
import 'package:presentation/screen/task/model/task_item.dart';
import 'package:presentation/screen/task/task_list_view_model.dart';
import 'package:presentation/screen/task/widget/task_list_widget.dart';

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
              _buildContent(),
              if (isLoading) _buildBottomLoading(),
            ],
          );
        });
  }

  Widget _buildContent() {
    return StreamBuilder<List<TaskItem>>(
        stream: _viewModel.taskItemsStream,
        builder: (_, snapshot) {
          final tasks = snapshot.data ?? [];
          if (!snapshot.hasError && tasks.isEmpty) {
            return const Center(child: Loading());
          }

          return TaskListWidget(
            tasks,
            onLoadMore: () => _viewModel.loadMore(),
            onDeleteItem: _viewModel.onDeleteTask,
          );
        });
  }

  Loading _buildBottomLoading() {
    return const Loading(margin: EdgeInsets.only(bottom: 24));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
