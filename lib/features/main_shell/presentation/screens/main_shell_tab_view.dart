import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainShellTabView extends ConsumerWidget {
  const MainShellTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('MainShellTabView'),
    );
  }
}
