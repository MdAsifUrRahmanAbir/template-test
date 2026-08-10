import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final resetPasswordControllerProvider = NotifierProvider<ResetPasswordController, AsyncValue<void>>(ResetPasswordController.new);
