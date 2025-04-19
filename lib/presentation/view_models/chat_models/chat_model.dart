import 'package:flutter/material.dart';
import 'package:test_please_run/data/models/message.dart';
import 'package:test_please_run/domain/chat/chat_notifier.dart';
import 'package:test_please_run/domain/chat/chat_state.dart';

class ChatPageViewModel {
  final ChatPageState model;
  final ChatPageNotifier notifier;

  ChatPageViewModel({
    required this.model,
    required this.notifier,
  });

  List<Message> get messages => model.messages ?? [];
  bool get isLoading => model.isLoading;
  bool isMe(String id) => notifier.isMeSendMessage(id);
  TextEditingController get controller => notifier.messageController;

  void sendMessage() => notifier.sendMessage();
}