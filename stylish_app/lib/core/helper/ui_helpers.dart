import 'package:flutter/material.dart';
import '../constants/colors_app.dart';

Color getSwitchColor(bool isSelected) {
  return isSelected
      ? ColorsApp.switchButtonPrimary
      : ColorsApp.switchButtonSecondary;
}

Color getTextColor(bool isSelected) {
  return isSelected ? ColorsApp.textColorLight : ColorsApp.textColor;
}
