import 'package:flutter/material.dart';
import 'package:task_management/model/status.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen(this.status, {super.key});

  final Status status;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.status.name));
  }
}
