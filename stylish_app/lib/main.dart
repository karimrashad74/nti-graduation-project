import 'package:flutter/material.dart';
import 'package:stylish_app/core/constants/assets_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: AssetsApp.icons.logo.svg()));
  }
}
