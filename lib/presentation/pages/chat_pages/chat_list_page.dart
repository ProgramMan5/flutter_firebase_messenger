import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/constants/colors.dart';
import 'package:test_please_run/core/providers/view_models.dart';
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/presentation/pages/chat_pages/chat_page.dart';
import 'package:test_please_run/presentation/view_models/chat_models/chat_list_model.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(chatListPageViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorOfAppBar,
      appBar: AppBar(
        backgroundColor: AppColors.colorOfSecondButtonColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
                style: TextStyle(
                  color: AppColors.colorOfText,
                ),
                'Чаты'),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/friends_list_page');
              },
              icon: Icon(
                color: AppColors.colorOfText,
                Icons.group,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: () {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (vm.chats.isEmpty) {
                return const Center(child: Text('Чаты не найдены'));
              }
              return ListView.builder(
                itemCount: vm.chats.length,
                itemBuilder: (context, index) {
                  final chat = vm.chats[index];
                  return ChatTileWidget(
                    model: vm,
                    chat: chat,
                  );
                },
              );
            }(),
          ),
        ],
      ),
    );
  }
}

class ChatTileWidget extends StatelessWidget {
  final ChatListViewModel model;
  final Chat chat;

  const ChatTileWidget({
    super.key,
    required this.model,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.lastMessage;
    final opponentId = model.getOpponentId(chat);
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.lightBlue, width: 1),
          bottom: BorderSide(color: AppColors.lightBlue, width: 1),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                chatId: chat.chatId,
                opponentId: model.getOpponentId(chat),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorOfBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(style: TextStyle(color: AppColors.colorOfText), opponentId),
            Text(
              style: TextStyle(color: AppColors.colorOfDate),
              lastMessage.length > 10
                  ? '${lastMessage.substring(0, 10)}...'
                  : lastMessage,
            ),
          ],
        ),
      ),
    );
  }
}
