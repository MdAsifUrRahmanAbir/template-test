import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsModeController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final analyticsModeControllerProvider = NotifierProvider<AnalyticsModeController, AsyncValue<void>>(AnalyticsModeController.new);
