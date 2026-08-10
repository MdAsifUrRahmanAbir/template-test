import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final activityControllerProvider = NotifierProvider<ActivityController, AsyncValue<void>>(ActivityController.new);
