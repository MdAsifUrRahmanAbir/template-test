import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderListController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final orderListControllerProvider = NotifierProvider<OrderListController, AsyncValue<void>>(OrderListController.new);
