import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/app.dart';
import 'package:test_please_run/core/app_initializer.dart';

void main() async {
  await AppInitializer.initializeApp();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

///базовый минимум:
/// авторизация +
/// поиск других пользователей и добавление их в друзья +-
/// создание чатов между пользователями +
/// отправка сообщений в чат +


///продвинутый минимум
/// ...

//структура firestore:

// /users/userId
//    name: "Alex"
//    /friends/friendId
//        friendId: "userId1"
//    /chats/chatId
//    chatId: "chatId1"
//
// /chats/chatId
//    participantsId: ["userId1", "userId2"]
//    lastMessage: "Привет, как дела?"
//    lastMessageTimestamp: "2023-10-01T12:00:00Z"
//    /messages/messageId
//    senderId: "userId1"
//    text: "Привет!"
//    timestamp: "2023-10-01T12:00:00Z"
