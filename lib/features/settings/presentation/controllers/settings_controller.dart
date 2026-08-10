import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final settingsControllerProvider = NotifierProvider<SettingsController, AsyncValue<void>>(SettingsController.new);
