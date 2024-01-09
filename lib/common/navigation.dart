import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWoData(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intentReplacment(String routename) {
    navigatorKey.currentState?.pushReplacementNamed(routename);
  }

  static intentReplacmentWithData(String routename, Object arguments) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routename, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}
