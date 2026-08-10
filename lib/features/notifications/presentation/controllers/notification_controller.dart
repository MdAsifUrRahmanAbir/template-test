import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final notificationControllerProvider = NotifierProvider<NotificationController, AsyncValue<void>>(NotificationController.new);
