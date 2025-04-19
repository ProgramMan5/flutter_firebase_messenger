import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/auth_pages/auth_page.dart';
import 'presentation/pages/auth_pages/main_auth_menu_page.dart';
import 'presentation/pages/auth_pages/reg_page.dart';
import 'presentation/pages/chat_pages/chat_list_page.dart';
import 'presentation/pages/friends_pages/friends_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/chat_list_page': (context) => const ChatList(),
          '/main_auth_page': (context) => const MainAuthMenu(),
          '/register_page': (context) => const RegisterPage(),
          '/auth_page': (context) => const AuthPage(),
          '/friends_list_page': (context) => const UsersListPage(),
        },
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? '/main_auth_page'
            : '/chat_list_page',
    );
  }
}
