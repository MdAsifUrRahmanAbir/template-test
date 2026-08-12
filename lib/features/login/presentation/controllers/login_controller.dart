import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/login_repository.dart';

class LoginController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  LoginRepository get _repository => ref.read(loginRepositoryProvider);

}
