import 'package:flutter/material.dart';
import 'package:task_management/app.dart';
import 'package:task_management/dependency_builder.dart';

void main() {

  DependencyBuilder().build();
  runApp(const App());
}
