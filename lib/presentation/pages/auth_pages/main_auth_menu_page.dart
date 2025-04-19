import 'package:flutter/material.dart';

class MainAuthMenu extends StatelessWidget {
  const MainAuthMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Аторизация"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/auth_page');
                },
                child: Text("Войти"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_page');
                },
                child: Text("Зарегестрироваться"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
