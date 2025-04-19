import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_please_run/core/session/session.dart';
import 'package:test_please_run/data/models/user.dart';
import 'package:test_please_run/domain/interfaces/users_repository.dart';

class UsersFirestoreRepository implements UsersRepository {
  final SessionService _sessionService;

  UsersFirestoreRepository({required SessionService sessionService})
      : _sessionService = sessionService;

  String? get _userId => _sessionService.currentUserId;

  @override
  Stream<List<User>> getAllUsersStream() {
    if (_userId == null) throw Exception('Пользователь не авторизован');
    return FirebaseFirestore.instance.collection('users').snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.where((doc) => doc.id != _userId).map((doc) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          return User.fromMap(doc.id, userData);
        }).toList();
      },
    );
  }

  @override
  Stream<Set<String>> getFriendsStream() {
    if (_userId == null) throw Exception('Пользователь не авторизован');
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .collection('friends')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data()['friendId'] as String)
          .toSet();
    });
  }


  @override
  Future<void> addFriend(String friendId) async {
    if (_userId == null) throw Exception('Пользователь не авторизован');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('friends')
          .doc(friendId)
          .set(
        {
          'friendId': friendId,
        },
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .collection('friends')
          .doc(_userId)
          .set(
        {
          'friendId': _userId,
        },
      );
    } catch (e) {
      throw Exception('Ошибка добавления в друзья $e');
    }
  }

  @override
  Future<void> deleteFriend(String friendId) async {
    if (_userId == null) throw Exception('Пользователь не авторизован');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('friends')
          .doc(friendId)
          .delete();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .collection('friends')
          .doc(_userId)
          .delete();
    } catch (e) {
      throw Exception('Ошибка удаления из друзей $e');
    }
  }
}
