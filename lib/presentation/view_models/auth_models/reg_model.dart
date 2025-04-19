import 'package:flutter/material.dart';
import 'package:test_please_run/presentation/view_models/auth_models/auth_base.dart';




class RegisterPageNotifier extends AuthBaseNotifier {
  final TextEditingController nameController = TextEditingController();

  RegisterPageNotifier({required super.authService});

  Future<void> register() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      await authService.registerUser(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      state = state.copyWith(isLoading: false, isSuccess: true, error: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Ошибка в регистрации: $e',
        isSuccess: false,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
