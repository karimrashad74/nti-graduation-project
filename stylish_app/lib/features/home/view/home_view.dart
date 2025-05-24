import 'package:flutter/material.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.primaryColor,
        title: Text(
          'Home',
          style: TextStylesApp.getStartTitle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to Stylish App!',
          style: TextStylesApp.getStartSubtitle,
        ),
      ),
    );
  }
}
