import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<void> navigateTo(String routeName) async {
    await navigatorKey.currentState?.pushNamed(routeName);
  }
}
