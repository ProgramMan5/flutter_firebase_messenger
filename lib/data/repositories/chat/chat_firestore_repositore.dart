import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_please_run/data/models/chat.dart';
import 'package:test_please_run/data/models/message.dart';
import 'package:test_please_run/domain/interfaces/chat_repository.dart';

class ChatFirestoreRepository implements ChatRepository {
  @override
  Future<void> createChat(String userId, String friendId) async {
    List<String> participants = [userId, friendId]..sort();
    String chatId = participants.join('_');

    try {
      final chatDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();
      if (chatDoc.exists) return;

      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'participantsId': participants,
        'lastMessage': 'Чат создан',
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'text': 'Привет! Я создал этот чат чтобы общаться с тобой!',
        'senderId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .set({'chatId': chatId});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .collection('chats')
          .doc(chatId)
          .set({'chatId': chatId});
    } catch (e) {
      throw Exception('Не удалось создать чат: $e');
    }
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .snapshots()
        .asyncMap((snapshot) async {
      final chatIds = snapshot.docs.map((doc) => doc.id).toList();

      if (chatIds.isEmpty) return [];

      final chatSnapshots = await FirebaseFirestore.instance
          .collection('chats')
          .where(FieldPath.documentId, whereIn: chatIds)
          .orderBy('lastMessageTimestamp', descending: true)
          .get();

        return chatSnapshots.docs
            .map((doc) => Chat.fromMap(doc.id, doc.data()))
            .toList();

    });
  }

  @override
  Future<void> sendMessage(String chatId, String text, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': userId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'lastMessage': text,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Не удалось отправить сообщение: $e');
    }
  }

  @override
  Stream<List<Message>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
