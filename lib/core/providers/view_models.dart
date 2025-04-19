import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/providers/notifiers.dart';
import 'package:test_please_run/presentation/view_models/chat_models/chat_list_model.dart';
import 'package:test_please_run/presentation/view_models/chat_models/chat_model.dart';

final chatPageViewModelProvider = Provider.autoDispose
    .family<ChatPageViewModel, ({String chatId, String opponentId})>(
  (ref, args) {
    final model = ref.watch(chatPageNotifierProvider(args));
    final notifier = ref.read(chatPageNotifierProvider(args).notifier);
    return ChatPageViewModel(model: model, notifier: notifier);
  },
);

final chatListPageViewModelProvider = Provider<ChatListViewModel>((ref) {
  final model = ref.watch(chatListPageNotifierProvider);
  final notifier = ref.read(chatListPageNotifierProvider.notifier);
  return ChatListViewModel(model: model, notifier: notifier);
});
