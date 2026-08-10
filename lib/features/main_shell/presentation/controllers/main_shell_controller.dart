import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainShellController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final mainShellControllerProvider = NotifierProvider<MainShellController, AsyncValue<void>>(MainShellController.new);
