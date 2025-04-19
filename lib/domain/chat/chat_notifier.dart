import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/data/models/message.dart';
import 'package:test_please_run/domain/chat/chat_service.dart';
import 'package:test_please_run/domain/chat/chat_state.dart';


class ChatPageNotifier extends StateNotifier<ChatPageState> {
  final ChatService _chatFirestoreService;
  final TextEditingController messageController = TextEditingController();
  StreamSubscription<List<Message>>? _messagesSubscription;

  ChatPageNotifier({
    required ChatService chatFirestoreService,
    required ChatPageState initialState,
  })  : _chatFirestoreService = chatFirestoreService,
        super(initialState) {
    _loadMessages(initialState.chatId);
  }

  void _loadMessages(String chatId) {
    _messagesSubscription?.cancel();
    _messagesSubscription =
        _chatFirestoreService.getMessages(chatId).listen((messages) {
          state = state.copyWith(messages: messages, isLoading: false);
        }, onError: (e) {
          state = state.copyWith(error: e.toString(), isLoading: false);
        });
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      _chatFirestoreService.sendMessage(state.chatId, text);
      messageController.clear();
    }
  }
  bool isMeSendMessage(String senderId){
    return _chatFirestoreService.isMeSendMessage(senderId);
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    messageController.dispose();
    super.dispose();
  }
}