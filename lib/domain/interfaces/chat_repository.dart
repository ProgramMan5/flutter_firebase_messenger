
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/data/models/message.dart';

abstract class ChatRepository {
  Future<void> createChat(String userId, String friendId);
  Stream<List<Chat>> getChats(String userId);
  Future<void> sendMessage(String chatId, String text, String userId);
  Stream<List<Message>> getMessages(String chatId);
}