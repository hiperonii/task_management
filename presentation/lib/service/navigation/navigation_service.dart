import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:presentation/service/navigation/routes.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> navigateTo<T extends Object?, V extends Object?>(Routes route, {V? arguments}) {
    final state = navigatorKey.currentState;
    if (state == null) {
      log('currentState is null');
      return Future.value(null);
    }

    return state.pushNamed(route.name, arguments: arguments);
  }
}
