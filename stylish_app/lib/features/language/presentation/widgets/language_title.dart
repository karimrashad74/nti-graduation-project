import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/localisation/translations_keys.dart';

class LanguageTitle extends StatelessWidget {
  const LanguageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      TranslationsKeys.language.tr,
      style: const TextStyle(fontSize: 18),
    );
  }
}
