import 'package:test_please_run/data/models/user.dart';
import 'package:test_please_run/domain/interfaces/user_repository.dart';


class UserService {
  final UserRepository _userRepository;

  UserService({
    required UserRepository userFirestoreRepository,
  }) : _userRepository = userFirestoreRepository;

  Stream<User> getUser(String userId) {
    return _userRepository.getUser(userId).handleError((e) {
      throw Exception('Get user error: $e');
    });
  }

  Future<User> getUserOnce(String userId) async {
    try {
      return await _userRepository.getUserOnce(userId);
    } catch (e) {
      throw Exception('Get user once error: $e');
    }
  }
}
