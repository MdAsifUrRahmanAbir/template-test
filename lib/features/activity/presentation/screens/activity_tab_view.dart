import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityTabView extends ConsumerWidget {
  const ActivityTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('ActivityTabView'),
    );
  }
}
