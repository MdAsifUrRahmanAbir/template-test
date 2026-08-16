import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_test/core/theme/app_theme.dart';
import 'package:template_test/routes/app_router.dart';

import 'core/observers/riverpod_logging_observer.dart';
import 'core/theme/theme_controller.dart';
import 'routes/app_initialization.dart';

void main() {
  AppInitialization.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [RiverpodLoggingObserver()],
      child: PosApp(),
    ),
  );
}

class PosApp extends ConsumerWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'POS System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
