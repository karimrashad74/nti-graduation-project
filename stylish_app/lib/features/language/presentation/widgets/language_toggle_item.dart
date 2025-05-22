import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/ui_helpers.dart';

class LanguageToggleItem extends StatelessWidget {
  final String langKey;
  final bool isSelected;

  const LanguageToggleItem({
    required this.langKey,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      color: getSwitchColor(isSelected),
      child: Text(
        langKey.tr,
        style: TextStyle(
          color: getTextColor(isSelected),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
