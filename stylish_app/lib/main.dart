import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/config/cache/cache_helper.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/features/auth/view/login_view.dart';
import 'package:stylish_app/features/auth/view/register_view.dart';
import 'package:stylish_app/features/home/view/home_view.dart';
import 'package:stylish_app/features/onboarding/view/onboarding_view.dart';
import 'package:stylish_app/features/splash/splash_screen.dart';

import 'config/localisation/translations.dart';
import 'config/localisation/translations_keys.dart';
import 'features/get_start/view/get_start_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish',
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale(TranslationsKeys.en),
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsApp.scaffoldBackgroundColor,
        primaryColor: ColorsApp.primaryColor,
      ),
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(
          name: OnboardingView.routeName,
          page: () => const OnboardingView(),
        ),
        GetPage(name: GetStartView.routeName, page: () => const GetStartView()),
        GetPage(name: LoginView.routeName, page: () => const LoginView()),
        GetPage(name: RegisterView.routeName, page: () => const RegisterView()),
        GetPage(name: HomeView.routeName, page: () => const HomeView()),
      ],
    );
  }
}
