import 'package:flutter/material.dart';
import 'package:task_management/dependency_builder.dart';
import 'package:task_management/screen/main_screen.dart';
import 'package:task_management/service/navigation/navigation_service.dart';
import 'package:task_management/service/navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      navigatorKey: locator.get<NavigationService>().navigatorKey,
      routes: routeToScreen,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MainScreen(),
    );
  }
}
