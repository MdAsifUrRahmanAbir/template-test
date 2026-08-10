import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShellNavigationItem extends ConsumerWidget {
  const ShellNavigationItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('ShellNavigationItem'),
    );
  }
}
