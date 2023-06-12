import 'package:flutter/cupertino.dart';
import 'package:task_management/screen/passcode/passcode_screen.dart';

enum Routes {
  passcode,
}

Map<String, WidgetBuilder> routeToScreen = {
  Routes.passcode.name: (context) => const PasscodeScreen(),
};
