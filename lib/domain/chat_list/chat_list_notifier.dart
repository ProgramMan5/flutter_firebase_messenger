import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/domain/chat_list/chat_list_service.dart';
import 'package:test_please_run/domain/chat_list/chat_list_state.dart';

class ChatListPageNotifier extends StateNotifier<ChatListState> {
  final ChatListService _chatListService;

  StreamSubscription<List<Chat>>? _chatsSubscription;

  ChatListPageNotifier({
    required ChatListService chatFirestoreService,
  })  : _chatListService = chatFirestoreService,
        super(ChatListState(isLoading: true)) {
    _loadChats();
  }

  void _loadChats() {
    _chatsSubscription?.cancel();

    _chatsSubscription = _chatListService.getChats().listen(
      (chats) {
        state = state.copyWith(
          isLoading: false,
          chats: chats,
          error: null,
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }

  String getOpponentId(Chat chat) {
    return _chatListService.getOpponentId(chat);
  }

  @override
  void dispose() {
    _chatsSubscription?.cancel();
    super.dispose();
  }
}
