import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String text;
  final DateTime timeStamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.text,
    required this.timeStamp,
  });

  factory Message.fromMap(String messageId, Map<String, dynamic> data) {
    return Message(
      messageId: messageId,
      senderId: data['senderId'],
      text: data['text'],
      timeStamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}