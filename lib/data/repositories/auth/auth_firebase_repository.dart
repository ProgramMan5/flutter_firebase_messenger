import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_please_run/domain/interfaces/auth_repository.dart';


class AuthFirebaseRepository extends AuthRepository {
  final FirebaseAuth _auth;

  AuthFirebaseRepository({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<UserCredential> loginUser(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> registerUser(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  @override
  String? get currentUserId => _auth.currentUser?.uid;
}
