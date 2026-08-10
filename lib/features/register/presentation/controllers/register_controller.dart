import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final registerControllerProvider = NotifierProvider<RegisterController, AsyncValue<void>>(RegisterController.new);
