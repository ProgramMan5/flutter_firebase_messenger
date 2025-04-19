import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/providers/services.dart';
import 'package:test_please_run/domain/chat/chat_notifier.dart';
import 'package:test_please_run/domain/chat/chat_state.dart';
import 'package:test_please_run/domain/chat_list/chat_list_notifier.dart';
import 'package:test_please_run/domain/chat_list/chat_list_state.dart';
import 'package:test_please_run/presentation/view_models/auth_models/auth_base.dart';
import 'package:test_please_run/presentation/view_models/auth_models/reg_model.dart';
import 'package:test_please_run/presentation/view_models/auth_models/sign_in_model.dart';
import 'package:test_please_run/presentation/view_models/users_models/users_list_model.dart';

final registerPageNotifierProvider =
    StateNotifierProvider<RegisterPageNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return RegisterPageNotifier(authService: authService);
});

final loginPageNotifierProvider =
    StateNotifierProvider<LoginPageNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return LoginPageNotifier(authService: authService);
});

final chatListPageNotifierProvider =
    StateNotifierProvider.autoDispose<ChatListPageNotifier, ChatListState>(
        (ref) {
  final chatListService = ref.watch(chatListServiceProvider);
  return ChatListPageNotifier(chatFirestoreService: chatListService);
});

final usersListPageNotifierProvider =
    StateNotifierProvider.autoDispose<UsersListPageNotifier, UsersListState>(
        (ref) {
  final usersService = ref.watch(usersServiceProvider);
  return UsersListPageNotifier(usersService: usersService);
});

final chatPageNotifierProvider = StateNotifierProvider.autoDispose.family<
    ChatPageNotifier, ChatPageState, ({String chatId, String opponentId})>(
  (ref, args) {
    final chatService = ref.read(chatServiceProvider);
    return ChatPageNotifier(
      chatFirestoreService: chatService,
      initialState: ChatPageState(
        chatId: args.chatId,
        opponentId: args.opponentId,
        isLoading: true,
      ),
    );
  },
);
