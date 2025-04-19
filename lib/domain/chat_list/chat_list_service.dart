import 'package:test_please_run/core/session/session.dart';
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/domain/interfaces/chat_repository.dart';

class ChatListService {
  final ChatRepository chatRepository;
  final SessionService sessionService;

  ChatListService({
    required this.chatRepository,
    required this.sessionService,
  });

  Stream<List<Chat>> getChats() {
    final userId = sessionService.currentUserId;
    if (userId == null) throw Exception('Пользователь не авторизован');
    return chatRepository.getChats(userId);
  }

  String getOpponentId(Chat chat) {
    final userId = sessionService.currentUserId;
    if (userId == null) throw Exception('Пользователь не авторизован');
    return chat.participantsId.firstWhere((id) => id != userId);
  }
}
