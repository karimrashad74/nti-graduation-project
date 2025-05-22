import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/config/localisation/translations_keys.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';

import 'config/localisation/translations.dart';
import 'features/language/presentation/view/language_view.dart';

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
      home: Scaffold(
        body: Column(
          children: [
            AssetsApp.icons.logo.svg(),
            Text(TranslationsKeys.appTitle.tr),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const LanguageView());
              },
              child: const Text('Change Language'),
            ),
          ],
        ),
      ),
    );
  }
}
