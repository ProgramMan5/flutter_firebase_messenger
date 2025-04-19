import 'package:test_please_run/data/models/chat.dart';

class ChatListState {
  final bool isLoading;
  final List<Chat>? chats;
  final String? error;

  ChatListState({
    this.isLoading = false,
    this.chats,
    this.error,
  });

  ChatListState copyWith({
    bool? isLoading,
    List<Chat>? chats,
    String? error,
  }) {
    return ChatListState(
      isLoading: isLoading ?? this.isLoading,
      chats: chats ?? this.chats,
      error: error ?? this.error,
    );
  }
}