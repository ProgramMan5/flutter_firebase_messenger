import 'package:test_please_run/data/models/message.dart';

class ChatPageState {
  final bool isLoading;
  final String chatId;
  final String opponentId;
  final List<Message>? messages;
  final String? error;

  ChatPageState({
    this.isLoading = false,
    required this.chatId,
    required this.opponentId,
    this.messages,
    this.error,
  });

  ChatPageState copyWith({
    bool? isLoading,
    String? chatId,
    String? opponentId,
    List<Message>? messages,
    String? error,
  }) {
    return ChatPageState(
      isLoading: isLoading ?? this.isLoading,
      chatId: chatId ?? this.chatId,
      opponentId: opponentId ?? this.opponentId,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }
}