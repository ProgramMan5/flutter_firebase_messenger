import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_please_run/core/providers/notifiers.dart';
import 'package:test_please_run/presentation/view_models/auth_models/auth_base.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(registerPageNotifierProvider);

    ref.listen<AuthState>(registerPageNotifierProvider, (prev, next) {
      if (next.isSuccess && context.mounted) {
        Navigator.pushNamed(context, '/chat_list_page');
      }

      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ref
                  .read(registerPageNotifierProvider.notifier)
                  .nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ref
                  .read(registerPageNotifierProvider.notifier)
                  .emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ref
                  .read(registerPageNotifierProvider.notifier)
                  .passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ref.read(registerPageNotifierProvider.notifier).register();
              },
              child: model.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Зарегистрироваться"),
            ),
          ],
        ),
      ),
    );
  }
}
