import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/data/models/user_with_friend_status.dart';
import 'package:test_please_run/domain/services/firestore_service/users_service.dart';

class UsersListState {
  final List<UserWithFriendStatus>? loadingUsers;
  final bool isLoadingTile;
  final bool isLoading;
  final String? error;

  UsersListState({
    this.loadingUsers,
    this.isLoadingTile = false,
    this.isLoading = false,
    this.error,
  });

  UsersListState copyWith({
    List<UserWithFriendStatus>? loadingUsers,
    bool? isLoadingTile = false,
    bool? isLoading = false,
    String? error,
  }) {
    return UsersListState(
      loadingUsers: loadingUsers ?? this.loadingUsers,
      isLoadingTile: isLoadingTile ?? this.isLoadingTile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UsersListPageNotifier extends StateNotifier<UsersListState> {
  final UsersService _usersService;
  StreamSubscription<List<UserWithFriendStatus>>? _usersSubscription;

  UsersListPageNotifier({
    required UsersService usersService,
  })  : _usersService = usersService,
        super(UsersListState(isLoading: true)) {
    _loadUsers();
  }

  void _loadUsers() {
    _usersSubscription?.cancel();
    _usersSubscription = _usersService.getUsersWithFriendStatusStream().listen(
      (users) {
        state = state.copyWith(
          loadingUsers: users,
          isLoadingTile: false,
          isLoading: false,
          error: null,
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }

  Future<void> addFriend(String friendId) => friendAction(friendId, true);

  Future<void> deleteFriend(String friendId) => friendAction(friendId, false);

  Future<void> createChat(String friendId) =>
      _usersService.createChat(friendId);

  Future<void> friendAction(String friendId, bool isAdd) async {
    await Future.delayed(Duration(milliseconds: 1000));
    try {
      if (isAdd) {
        await _usersService.addFriend(friendId);
      } else {
        await _usersService.deleteFriend(friendId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
