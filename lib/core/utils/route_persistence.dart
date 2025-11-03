import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutePersistence extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _saveLastRoute(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _saveLastRoute(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  Future<void> _saveLastRoute(Route? route) async {
    if (route?.settings.name == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_route', route!.settings.name!);
  }
}
