import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/session/session.dart';
import 'package:test_please_run/data/repositories/auth/auth_firebase_repository.dart';
import 'package:test_please_run/data/repositories/chat/chat_firestore_repositore.dart';
import 'package:test_please_run/data/repositories/user/user_firestore_repository.dart';
import 'package:test_please_run/data/repositories/users/users_firestore_repository.dart';
import 'package:test_please_run/domain/interfaces/auth_repository.dart';
import 'package:test_please_run/domain/interfaces/chat_repository.dart';
import 'package:test_please_run/domain/interfaces/user_repository.dart';
import 'package:test_please_run/domain/interfaces/users_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthFirebaseRepository();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatFirestoreRepository();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserFirestoreRepository();
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  final sessionService = ref.watch(sessionServiceProvider);
  return UsersFirestoreRepository(sessionService: sessionService);
});

final sessionServiceProvider = Provider<SessionService>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return SessionService(authRepository: authRepo);
});
