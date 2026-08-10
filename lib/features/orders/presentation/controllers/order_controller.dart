import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final orderControllerProvider = NotifierProvider<OrderController, AsyncValue<void>>(OrderController.new);
