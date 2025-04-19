import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/providers/notifiers.dart';
import 'package:test_please_run/data/models/user.dart';
import 'package:test_please_run/data/models/user_with_friend_status.dart';
import 'package:test_please_run/presentation/view_models/users_models/users_list_model.dart';


class UsersListPage extends ConsumerWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersListPageNotifierProvider);
    final users = state.loadingUsers;
    return Scaffold(
      appBar: AppBar(title: const Text('Пользователи')),
      body: Column(
        children: [
          Expanded(
            child: () {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.error != null) {
                return Center(child: Text('Ошибка: ${state.error}'));
              } else if (users == null || users.isEmpty) {
                return const Center(child: Text('Пользователи не найдены'));
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserTileWidget(
                    model: ref.read(usersListPageNotifierProvider.notifier),
                    user: user,
                    state: state,
                  );
                },
              );
            }(),
          ),
        ],
      ),
    );
  }
}

class UserTileWidget extends StatelessWidget {
  final UserWithFriendStatus user;
  final UsersListPageNotifier model;
  final UsersListState state;

  const UserTileWidget({
    super.key,
    required this.user,
    required this.model,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final User userData = user.user;
    return ListTile(
      leading: const Icon(Icons.person),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(userData.name),
          Row(
            children: [
              state.isLoading
                  ? CircularProgressIndicator()
                  : user.isFriend
                      ? FriendActionButton(
                          model: model,
                          user: userData,
                          successfulText: 'Пользователь удален из друзей',
                          action: () => model.deleteFriend(userData.id),
                          icon: Icon(Icons.person_remove),
                        )
                      : FriendActionButton(
                          model: model,
                          user: userData,
                          successfulText: 'Пользователь добавлен в друзья',
                          action: () => model.addFriend(userData.id),
                          icon: Icon(Icons.person_add),
                        ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => model.createChat(userData.id),
                child: Icon(Icons.chat),
              ),
            ],
          ),
        ],
      ),
      subtitle: Text('ID: ${userData.id}'),
    );
  }
}

class FriendActionButton extends StatelessWidget {
  final UsersListPageNotifier model;
  final User user;
  final String successfulText;
  final Future<void> Function() action;
  final Icon icon;

  const FriendActionButton({
    super.key,
    required this.model,
    required this.user,
    required this.successfulText,
    required this.action,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        try {
          await action();
          messenger.showSnackBar(
            SnackBar(content: Text(successfulText)),
          );
        } catch (e) {
          messenger.showSnackBar(
            SnackBar(content: Text('Ошибка: $e')),
          );
        }
      },
      child: icon,
    );
  }
}
