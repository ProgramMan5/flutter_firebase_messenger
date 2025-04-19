

import 'package:test_please_run/presentation/view_models/auth_models/auth_base.dart';

class LoginPageNotifier extends AuthBaseNotifier {
  LoginPageNotifier({required super.authService});

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await authService.loginUser(
        emailController.text,
        passwordController.text,
      );
      state = state.copyWith(isLoading: false, isSuccess: true, error: null);
    } catch (e) {
      throw Exception('Ошибка логина $e');
    }
  }
}
