import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:test_please_run/domain/interfaces/auth_repository.dart';
import 'package:test_please_run/domain/interfaces/user_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthService({
    required this.authRepository,
    required this.userRepository,
  });

  Future<bool> registerUser(String email, String password, String name) async {
    try {
      firebaseAuth.UserCredential user =
          await authRepository.registerUser(email, password);

      String? id = user.user?.uid;

      if (id != null) {
        await userRepository.createUser(id, name);
      } else {
        throw Exception('User ID is null');
      }
      return true;
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await authRepository.loginUser(email, password);
      return true;
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
