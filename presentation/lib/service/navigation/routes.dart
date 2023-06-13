import 'package:flutter/cupertino.dart';
import 'package:presentation/screen/main_screen.dart';
import 'package:presentation/screen/passcode/passcode_screen.dart';

enum Routes {
  main,
  passcode,
}

Map<String, WidgetBuilder> routeToScreen = {
  Routes.main.name: (context) => const MainScreen(),
  Routes.passcode.name: (context) => const PasscodeScreen(),
};
