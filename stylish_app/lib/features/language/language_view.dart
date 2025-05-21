import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/core/constants/colors_app.dart';

import '../../config/localisation/translations_keys.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TranslationsKeys.settings.tr)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TranslationsKeys.language.tr,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 20),

            ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              constraints: const BoxConstraints(minHeight: 50, minWidth: 120),
              isSelected: [
                selectedLang == TranslationsKeys.ar,
                selectedLang == TranslationsKeys.en,
              ],
              onPressed: (index) {
                final lang =
                    index == 0 ? TranslationsKeys.ar : TranslationsKeys.en;
                setState(() {
                  selectedLang = lang;
                  Get.updateLocale(Locale(lang));
                });
              },
              fillColor: Colors.transparent,
              color: ColorsApp.textColor,
              selectedColor: ColorsApp.textColorLight,
              renderBorder: false,
              children: [
                Container(
                  width: 120,
                  height: 50,
                  alignment: Alignment.center,
                  color:
                      selectedLang == TranslationsKeys.ar
                          ? ColorsApp.switchButtonPrimary
                          : ColorsApp.switchButtonSecondary,
                  child: Text(
                    TranslationsKeys.ar.tr,
                    style: TextStyle(
                      color:
                          selectedLang == TranslationsKeys.ar
                              ? ColorsApp.textColorLight
                              : ColorsApp.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 50,
                  alignment: Alignment.center,
                  color:
                      selectedLang == TranslationsKeys.en
                          ? ColorsApp.switchButtonPrimary
                          : ColorsApp.switchButtonSecondary,
                  child: Text(
                    TranslationsKeys.en.tr,
                    style: TextStyle(
                      color:
                          selectedLang == TranslationsKeys.en
                              ? ColorsApp.textColorLight
                              : ColorsApp.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
