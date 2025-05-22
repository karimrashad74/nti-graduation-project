import 'package:get/get.dart';

import 'ar_translations.dart';
import 'en_translations.dart';
import 'translations_keys.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    TranslationsKeys.en: enTranslations,
    TranslationsKeys.ar: arTranslations,
  };
}
