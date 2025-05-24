import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../config/localisation/translations_keys.dart';
import '../../../../core/constants/colors_app.dart';
import '../widgets/language_title.dart';
import '../widgets/language_toggle_buttons.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  late String selectedLang;

  @override
  void initState() {
    super.initState();
    selectedLang = Get.locale?.languageCode ?? TranslationsKeys.en;
  }

  void updateLanguage(String lang) {
    setState(() {
      selectedLang = lang;
      Get.updateLocale(Locale(lang));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorsApp.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(TranslationsKeys.settings.tr)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LanguageTitle(),
            const SizedBox(width: 20),
            LanguageToggleButtons(
              selectedLang: selectedLang,
              onLanguageChanged: updateLanguage,
            ),
          ],
        ),
      ),
    );
  }
}
