
import 'package:test_please_run/data/models/user.dart';

abstract class UserRepository{
  Stream<User> getUser(String userId);
  Future<User> getUserOnce(String userId);
  Future<void> createUser(String userId, String name);
}