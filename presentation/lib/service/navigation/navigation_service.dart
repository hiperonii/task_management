import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:presentation/service/navigation/routes.dart';

class NavigationService {
  NavigationService._();

  factory NavigationService() {
    return _instance ??= NavigationService._();
  }

  static NavigationService? _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> navigateTo<T extends Object?, V extends Object?>(Routes route, {V? arguments}) {
    final state = navigatorKey.currentState;
    if (state == null) {
      log('currentState is null');
      return Future.value(null);
    }

    return state.pushNamed<T>(route.name, arguments: arguments);
  }

  Future<T?> replaceEntireStack<T extends Object?>(Routes route) {
    final state = navigatorKey.currentState;
    if (state == null) {
      log('currentState is null');
      return Future.value(null);
    }

    return state.pushNamedAndRemoveUntil<T>(route.name, (_) => false);
  }
}
