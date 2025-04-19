import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/providers/repositories.dart';
import 'package:test_please_run/domain/chat/chat_service.dart';
import 'package:test_please_run/domain/chat_list/chat_list_service.dart';
import 'package:test_please_run/domain/services/firebase_auth_service/auth_service.dart';
import 'package:test_please_run/domain/services/firestore_service/user_service.dart';
import 'package:test_please_run/domain/services/firestore_service/users_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  return AuthService(authRepository: authRepo, userRepository: userRepo);
});

final chatServiceProvider = Provider<ChatService>((ref) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  final sessionService = ref.watch(sessionServiceProvider);
  return ChatService(
      chatRepository: chatRepo, sessionService: sessionService);
});

final userServiceProvider = Provider<UserService>((ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  return UserService(userFirestoreRepository: userRepo);
});

final chatListServiceProvider = Provider<ChatListService>((ref) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  final sessionService = ref.watch(sessionServiceProvider);
  return ChatListService(
      chatRepository: chatRepo, sessionService: sessionService);
});

final usersServiceProvider = Provider<UsersService>((ref) {
  final usersRepo = ref.watch(usersRepositoryProvider);
  final sessionService = ref.watch(sessionServiceProvider);
  final chatRepo = ref.watch(chatRepositoryProvider);
  return UsersService(
      usersRepository: usersRepo,
      chatRepository: chatRepo,
      sessionService: sessionService);
});

