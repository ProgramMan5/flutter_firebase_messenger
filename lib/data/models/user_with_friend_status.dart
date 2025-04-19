import 'package:test_please_run/data/models/user.dart';

class UserWithFriendStatus {
  final User user;
  final bool isFriend;

  UserWithFriendStatus({
    required this.user,
    required this.isFriend,
  });
}
