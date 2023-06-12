import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:presentation/screen/task/task_list_screen.dart';

class TaskTab {
  const TaskTab._(this.title, this.screen);

  final String title;
  final Widget screen;

  factory TaskTab(Status status) {
    return TaskTab._(status.name, TaskListScreen(status));
  }
}
