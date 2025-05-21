import 'package:flutter/material.dart';

abstract class ColorsApp {
  Color scaffoldBackgroundColor = Color.fromRGBO(253, 253, 253, 1);

  Color textColor = Color.fromRGBO(0, 0, 0, 1);
  Color sconedTextColor = Color.fromRGBO(168, 168, 169, 1);
  Color textColorLight = Color.fromRGBO(255, 255, 255, 1);
  Color sconedTextColorLight = Color.fromRGBO(242, 242, 242, 1);

  Color primaryColor = Color.fromRGBO(248, 55, 88, 1);
  Color secondaryColor = Color.fromRGBO(196, 196, 196, 1);

  Color activeOnboarding = Color.fromRGBO(23, 34, 59, 1);
  Color inactiveOnboarding = Color.fromRGBO(23, 34, 59, 0.2);
  Color backgroundOnboarding = Color.fromRGBO(255, 255, 255, 1);

  Color buttonPrimaryColor = Color.fromRGBO(248, 55, 88, 1);
  Color buttonSsecondaryColor = Color.fromRGBO(255, 255, 255, 1);

  Color formField = Color.fromRGBO(243, 243, 243, 1);
  Color borderFormField = Color.fromRGBO(168, 168, 169, 1);
  Color iconsFormField = Color.fromRGBO(98, 98, 98, 1);

  Color error = Color.fromARGB(255, 255, 0, 0);
}
