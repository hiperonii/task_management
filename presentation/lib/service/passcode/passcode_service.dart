import 'dart:async';

import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/navigation/routes.dart';

class PasscodeService {
  PasscodeService._();

  factory PasscodeService() {
    return _instance ??= PasscodeService._();
  }

  static PasscodeService? _instance;
  static const Duration _inactiveDuration = Duration(seconds: 10);

  Timer? _timer;
  bool _isStarted = false;

  void start() {
    _isStarted = true;
    reset();
  }

  void stop() {
    _isStarted = false;
    _timer?.cancel();
  }

  void reset() {
    if (!_isStarted) {
      return;
    }

    _timer?.cancel();
    _timer = Timer(_inactiveDuration, () {
      NavigationService().navigateTo(Routes.passcode);
    });
  }
}
