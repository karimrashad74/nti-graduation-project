import 'package:get/get.dart';

import 'translations_keys.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    TranslationsKeys.en: {
      TranslationsKeys.appTitle: 'Stylish',
      TranslationsKeys.welcome: 'Welcome to Stylish!',
      TranslationsKeys.login: 'Login',
      TranslationsKeys.register: 'Register',
      TranslationsKeys.settings: 'settings',
      TranslationsKeys.language: 'Language',
      TranslationsKeys.ar: 'AR',
      TranslationsKeys.en: 'EN',
    },
    TranslationsKeys.ar: {
      TranslationsKeys.appTitle: 'ستايلش',
      TranslationsKeys.welcome: 'مرحبًا بك في ستايلش!',
      TranslationsKeys.login: 'تسجيل الدخول',
      TranslationsKeys.register: 'إنشاء حساب',
      TranslationsKeys.settings: 'الإعدادات',
      TranslationsKeys.language: 'اللغة',
      TranslationsKeys.ar: 'عربي',
      TranslationsKeys.en: 'الإنجليزية',
    },
  };
}
