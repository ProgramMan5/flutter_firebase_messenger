import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_please_run/core/constants/colors.dart';
import 'package:test_please_run/core/providers/view_models.dart';
import 'dart:core';
import 'package:test_please_run/data/models/message.dart';

class ChatPage extends ConsumerWidget {
  final String chatId;
  final String opponentId;

  const ChatPage({
    super.key,
    required this.chatId,
    required this.opponentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(
        chatPageViewModelProvider((chatId: chatId, opponentId: opponentId)));

    return Scaffold(
      backgroundColor: AppColors.colorOfAppBar,
      appBar: AppBar(
        backgroundColor: AppColors.colorOfSecondButtonColor,
        title: Text(
          opponentId,
          style: TextStyle(color: AppColors.colorOfText),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    itemCount: vm.messages.length,
                    itemBuilder: (context, index) {
                      final message = vm.messages[index];
                      final isMyMessage = vm.isMe(message.senderId);
                      return _MessageBubble(
                          message: message, isMe: isMyMessage);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: vm.controller,
              style: TextStyle(color: AppColors.colorOfText),
              decoration: InputDecoration(
                hintText: 'Напиши сообщение...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () =>
                      vm.sendMessage(),
                ),
              ),
              onSubmitted: (_) =>
                  vm.sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const _MessageBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final timestamp = message.timeStamp;
    final timeFormatted = DateFormat('HH:mm').format(timestamp);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.lightBlue : AppColors.colorOfBackground,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                isMe ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: AppColors.colorOfText,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeFormatted,
              style: TextStyle(
                color: AppColors.colorOfDate,
                fontSize: 12,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
