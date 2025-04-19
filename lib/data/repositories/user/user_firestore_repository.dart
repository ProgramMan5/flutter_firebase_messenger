import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_please_run/data/models/user.dart';
import 'package:test_please_run/domain/interfaces/user_repository.dart';

class UserFirestoreRepository implements UserRepository {
  @override
  Stream<User> getUser(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return User.fromMap(userId, snapshot.data()!);
      }
      throw Exception('User not found');
    });
  }

  @override
  Future<User> getUserOnce(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        return User.fromMap(userId, doc.data() as Map<String, dynamic>);
      }
      throw Exception('User not found');
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  @override
  Future<void> createUser(String userId, String name) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,

      });
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
