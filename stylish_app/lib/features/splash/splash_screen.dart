import 'package:flutter/material.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/helper/navigation_helper.dart';

import '../language/presentation/view/language_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    NavigationHelper.navigateAfterDelay(
      context: context,
      page: const LanguageView(),
      delay: const Duration(seconds: 4),
      removeAll: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldBackgroundColor,
      body: Center(child: AssetsApp.icons.logo.svg(width: 274.99, height: 100)),
    );
  }
}
