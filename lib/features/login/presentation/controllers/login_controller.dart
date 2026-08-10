import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final loginControllerProvider = NotifierProvider<LoginController, AsyncValue<void>>(LoginController.new);
