import 'package:flutter/material.dart';
import 'package:stylish_app/config/cache/cache_helper.dart';
import 'package:stylish_app/config/cache/cache_keys.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/helper/navigation_helper.dart';

import '../auth/view/login_view.dart';
import '../home/view/home_view.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final token = CacheHelper.getData(key: CacheKeys.userToken);
      if (token != null && token != '') {
        NavigationHelper.pushAndRemoveUntilTo(context, const HomeView());
      } else {
        NavigationHelper.pushAndRemoveUntilTo(context, LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldBackgroundColor,
      body: Center(child: AssetsApp.icons.logo.svg(width: 274.99, height: 100)),
    );
  }
}
