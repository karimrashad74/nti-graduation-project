import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  static const String routeName = '/register';
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('Register Screen')),
    );
  }
}
