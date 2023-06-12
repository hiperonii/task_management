import 'package:flutter/cupertino.dart';
import 'package:presentation/screen/passcode/passcode_screen.dart';

enum Routes {
  passcode,
}

Map<String, WidgetBuilder> routeToScreen = {
  Routes.passcode.name: (context) => const PasscodeScreen(),
};
