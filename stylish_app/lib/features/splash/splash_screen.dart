import 'package:flutter/material.dart';
import 'package:stylish_app/config/cache/cache_helper.dart';
import 'package:stylish_app/config/cache/cache_keys.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/helper/navigation_helper.dart';

import '../auth/view/login_view.dart';
import '../get_start/view/get_start_view.dart';
import '../home/view/trending.dart';
import '../onboarding/view/onboarding_view.dart';

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
    Future.delayed(const Duration(seconds: 2), () async {
      final token = CacheHelper.getData(key: CacheKeys.userToken);
      final onboarding = await CacheHelper.getData(
        key: CacheKeys.onboardingCompleted,
      );
      final getStart = await CacheHelper.getData(
        key: CacheKeys.getStartCompleted,
      );
      if (token != null && token != '') {
        NavigationHelper.pushAndRemoveUntilTo(context, HomeView());
      } else if (onboarding == null) {
        NavigationHelper.pushAndRemoveUntilTo(context, const OnboardingView());
      } else if (getStart == null) {
        NavigationHelper.pushAndRemoveUntilTo(context, const GetStartView());
      } else {
        NavigationHelper.pushAndRemoveUntilTo(context, const LoginView());
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
