import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';
import 'package:stylish_app/core/helper/my_responsive.dart';

import '../../../config/localisation/translations_keys.dart';

class GetStartActions extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  const GetStartActions({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TranslationsKeys.startScreenTitle.tr,
          style: TextStylesApp.getStartTitle.copyWith(
            color: ColorsApp.textColorLight,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          TranslationsKeys.startScreenSubTitle.tr,
          style: TextStylesApp.getStartSubtitle.copyWith(
            color: ColorsApp.sconedTextColorLight,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: MyResponsive.width(context, value: 279),
          height: MyResponsive.height(context, value: 55),
          child: ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.buttonPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
            ),
            child: Text(
              TranslationsKeys.login.tr,
              style: TextStylesApp.getStartButton.copyWith(
                color: ColorsApp.textColorLight,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MyResponsive.width(context, value: 279),
          height: MyResponsive.height(context, value: 55),
          child: OutlinedButton(
            onPressed: onRegister,
            style: OutlinedButton.styleFrom(
              backgroundColor: ColorsApp.buttonSecondaryColor,
              side: BorderSide(color: ColorsApp.primaryColor, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              TranslationsKeys.register.tr,
              style: TextStylesApp.getStartButton.copyWith(
                color: ColorsApp.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
