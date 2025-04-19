import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/domain/services/firebase_auth_service/auth_service.dart';

class AuthBaseNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthBaseNotifier({
    required this.authService,
  }) : super(AuthState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
