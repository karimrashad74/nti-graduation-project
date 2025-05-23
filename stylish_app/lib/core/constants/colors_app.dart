import 'package:flutter/material.dart';

abstract class ColorsApp {
  static Color scaffoldBackgroundColor = Color.fromRGBO(253, 253, 253, 1);

  static Color textColor = Color.fromRGBO(0, 0, 0, 1);
  static Color sconedTextColor = Color.fromRGBO(168, 168, 169, 1);
  static Color textColorLight = Color.fromRGBO(255, 255, 255, 1);
  static Color sconedTextColorLight = Color.fromRGBO(242, 242, 242, 1);

  static Color primaryColor = Color.fromRGBO(248, 55, 88, 1);
  static Color secondaryColor = Color.fromRGBO(196, 196, 196, 1);

  static Color activeOnboarding = Color.fromRGBO(23, 34, 59, 1);
  static Color inactiveOnboarding = Color.fromRGBO(23, 34, 59, 0.2);
  static Color backgroundOnboarding = Color.fromRGBO(255, 255, 255, 1);

  static Color buttonPrimaryColor = Color.fromRGBO(248, 55, 88, 1);
  static Color buttonSecondaryColor = Color.fromRGBO(255, 255, 255, 1);

  static Color formField = Color.fromRGBO(243, 243, 243, 1);
  static Color borderFormField = Color.fromRGBO(168, 168, 169, 1);
  static Color iconsFormField = Color.fromRGBO(98, 98, 98, 1);

  static Color switchButtonPrimary = primaryColor;
  static Color switchButtonSecondary = Color.fromRGBO(255, 204, 213, 1);

  static Color error = Color.fromARGB(255, 255, 0, 0);
}
