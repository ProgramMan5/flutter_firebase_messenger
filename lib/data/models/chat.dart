import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_please_run/data/models/message.dart';

class Chat {
  final String chatId;
  final List<String> participantsId;
  final String lastMessage;
  final DateTime lastMessageTimestamp;
  final List<Message>? messages;

  Chat({
    required this.chatId,
    required this.participantsId,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.messages,
  });

  factory Chat.fromMap(String id, Map<String, dynamic> data,
      [List<Message>? messages]) {
    return Chat(
      chatId: id,
      participantsId: List<String>.from(data['participantsId']),
      lastMessage: data['lastMessage'],
      lastMessageTimestamp:
          (data['lastMessageTimestamp'] as Timestamp?)?.toDate() ??
              DateTime.now(),
      messages: messages,
    );
  }
}
