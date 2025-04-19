

import 'package:test_please_run/domain/interfaces/auth_repository.dart';

class SessionService {
  final AuthRepository authRepository;

  SessionService({required this.authRepository});

  String? get currentUserId => authRepository.currentUserId;
}