import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

/// A [NavigatorObserver] that logs navigation events.
/// It prints the route name (if provided) and the runtime type of the route.
/// This helps during debugging to see which screen is shown and when it is
/// popped. The logs appear in the console via `debugPrint`/`developer.log`.
class LoggingObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final name = route.settings.name ?? route.runtimeType;
    developer.log('🔁 Pushed route: $name');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final name = route.settings.name ?? route.runtimeType;
    developer.log('⤵️ Popped route: $name');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    final name = route.settings.name ?? route.runtimeType;
    developer.log('❎ Removed route: $name');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final name = newRoute?.settings.name ?? newRoute?.runtimeType;
    developer.log('🔁 Replaced route with: $name');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
