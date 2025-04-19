import 'dart:async';
import 'package:test_please_run/data/models/user.dart';

abstract class UsersRepository {
  Stream<List<User>> getAllUsersStream();

  Stream<Set<String>> getFriendsStream();

  Future<void> addFriend(String friendId);

  Future<void> deleteFriend(String friendId);
}
