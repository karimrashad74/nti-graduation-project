import 'package:flutter/material.dart';

import '../../../../config/localisation/translations_keys.dart';
import '../../../../core/constants/colors_app.dart';
import 'language_toggle_item.dart';

class LanguageToggleButtons extends StatelessWidget {
  final String selectedLang;
  final Function(String) onLanguageChanged;

  const LanguageToggleButtons({
    super.key,
    required this.selectedLang,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(8),
      constraints: const BoxConstraints(minHeight: 50, minWidth: 120),
      isSelected: [
        selectedLang == TranslationsKeys.ar,
        selectedLang == TranslationsKeys.en,
      ],
      onPressed: (index) {
        final lang = index == 0 ? TranslationsKeys.ar : TranslationsKeys.en;
        onLanguageChanged(lang);
      },
      fillColor: Colors.transparent,
      color: ColorsApp.textColor,
      selectedColor: ColorsApp.textColorLight,
      renderBorder: false,
      children: [
        LanguageToggleItem(
          langKey: TranslationsKeys.ar,
          isSelected: selectedLang == TranslationsKeys.ar,
        ),
        LanguageToggleItem(
          langKey: TranslationsKeys.en,
          isSelected: selectedLang == TranslationsKeys.en,
        ),
      ],
    );
  }
}
