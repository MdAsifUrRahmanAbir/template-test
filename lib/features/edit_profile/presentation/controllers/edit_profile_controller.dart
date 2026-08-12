import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }
}

final editProfileControllerProvider = NotifierProvider<EditProfileController, AsyncValue<void>>(EditProfileController.new);
