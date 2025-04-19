import 'package:test_please_run/core/session/session.dart';
import 'package:test_please_run/data/models/message.dart';
import 'package:test_please_run/domain/interfaces/chat_repository.dart';

class ChatService {
  final ChatRepository chatRepository;
  final SessionService sessionService;

  ChatService({
    required this.chatRepository,
    required this.sessionService,
  });

  Future<void> sendMessage(String chatId, String text) async {
    final userId = sessionService.currentUserId;
    if (userId == null) throw Exception('Пользователь не авторизован');
    await chatRepository.sendMessage(chatId, text, userId);
  }

  bool isMeSendMessage(String senderId) {
    final userId = sessionService.currentUserId;
    if (userId == null) throw Exception('Пользователь не авторизован');
    return sessionService.currentUserId == senderId;
  }

  Stream<List<Message>> getMessages(String chatId) {
    return chatRepository.getMessages(chatId);
  }
}
