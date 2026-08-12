import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_test/core/theme/app_theme.dart';
import 'package:template_test/routes/app_router.dart';

import 'routes/app_initialization.dart';

void main() {
  AppInitialization.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: PosApp(),
    ),
  );
}

class PosApp extends ConsumerWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'POS System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
