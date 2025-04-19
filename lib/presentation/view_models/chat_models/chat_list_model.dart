
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/domain/chat_list/chat_list_notifier.dart';
import 'package:test_please_run/domain/chat_list/chat_list_state.dart';

class ChatListViewModel {
  final ChatListState model;
  final ChatListPageNotifier notifier;

  ChatListViewModel({
    required this.model,
    required this.notifier,
  });
  bool get isLoading  => model.isLoading;
  List<Chat> get chats => model.chats ?? [];
  String getOpponentId(Chat chat) => notifier.getOpponentId(chat);
}
