import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_please_run/data/models/user.dart';


class UserHiveRepository {
  static const String _userBoxName = 'userBox';

  Future<User?> getUser(String userId) async {
    try {
      var box = Hive.box<User>(_userBoxName);
      return box.get(userId);
    } catch (e) {
      throw Exception('Failed to get user from Hive: $e');
    }
  }

  Future<void> saveUser(User user) async {
    try {
      var box = Hive.box<User>(_userBoxName);
      await box.put(user.id, user);
    } catch (e) {
      throw Exception('Failed to save user to Hive: $e');
    }
  }
}