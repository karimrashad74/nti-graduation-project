import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/features/splash/splash_screen.dart';

import 'config/localisation/translations.dart';
import 'config/localisation/translations_keys.dart';

void main() {
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
      home: SplashScreen(),
    );
  }
}
