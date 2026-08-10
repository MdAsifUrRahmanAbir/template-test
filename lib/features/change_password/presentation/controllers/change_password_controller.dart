import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final changePasswordControllerProvider = NotifierProvider<ChangePasswordController, AsyncValue<void>>(ChangePasswordController.new);
