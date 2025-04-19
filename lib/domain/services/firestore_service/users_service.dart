import 'package:rxdart/rxdart.dart';
import 'package:test_please_run/core/session/session.dart';
import 'package:test_please_run/data/models/user.dart';
import 'package:test_please_run/data/models/user_with_friend_status.dart';
import 'package:test_please_run/domain/interfaces/chat_repository.dart';
import 'package:test_please_run/domain/interfaces/users_repository.dart';

class UsersService {
  final UsersRepository _usersRepository;
  final ChatRepository _chatRepository;
  final SessionService _sessionService;

  UsersService({
    required UsersRepository usersRepository,
    required ChatRepository chatRepository,
    required SessionService sessionService,
  })  : _usersRepository = usersRepository,
        _chatRepository = chatRepository,
        _sessionService = sessionService;


  String? get _userId => _sessionService.currentUserId;


  Future<void> createChat(String friendId)async {
    if (_userId == null) throw Exception('Пользователь не зарегистрирован');
    _chatRepository.createChat(_userId!, friendId);
  }

  Stream<List<User>> _getAllUsersStream() {
    return _usersRepository.getAllUsersStream();
  }

  Stream<Set<String>> _getFriendsStream() {
    return _usersRepository.getFriendsStream();
  }

  Stream<List<UserWithFriendStatus>> getUsersWithFriendStatusStream() {
    if (_userId == null) throw Exception('Пользователь не авторизован');
    return Rx.combineLatest2(
      _getAllUsersStream(),
      _getFriendsStream(),
      (List<User> users, Set<String> friends) {
        return users.map((user) {
          return UserWithFriendStatus(
            user: user,
            isFriend: friends.contains(user.id),
          );
        }).toList();
      },
    );
  }

  Future<void> addFriend(String friendId) {
    return _usersRepository.addFriend(friendId);
  }

  Future<void> deleteFriend(String friendId) {
    return _usersRepository.deleteFriend(friendId);
  }
}
