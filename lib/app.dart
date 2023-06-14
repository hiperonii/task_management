import 'package:flutter/material.dart';
import 'package:presentation/screen/passcode/passcode_screen.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/navigation/routes.dart';
import 'package:presentation/service/passcode/passcode_service.dart';
import 'package:task_management/dependency_builder.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator.get<NavigationService>().navigatorKey,
      routes: routeToScreen,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      builder: (_, Widget? child) {
        return Listener(
          onPointerDown: (_) {
            locator.get<PasscodeService>().reset();
          },
          child: child,
        );
      },
      home: const PasscodeScreen(),
    );
  }
}
