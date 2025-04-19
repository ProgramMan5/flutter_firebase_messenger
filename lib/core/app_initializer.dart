import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppInitializer {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}
