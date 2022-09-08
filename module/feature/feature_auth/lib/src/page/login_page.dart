import 'package:flutter/material.dart';
import 'package:oni_router/oni_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginView(
      context.get<String>(AuthBundle.idLoginBundle),
    );
  }
}

class LoginView extends StatelessWidget {
  final String idUser;

  const LoginView(this.idUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const SafeArea(
        child: Text('Test'),
      ),
    );
  }
}
