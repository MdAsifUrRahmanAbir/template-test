import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderCardItem extends ConsumerWidget {
  const OrderCardItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('OrderCardItem'),
    );
  }
}
