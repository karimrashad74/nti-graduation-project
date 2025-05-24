import 'package:flutter/material.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';
import 'package:stylish_app/core/helper/my_responsive.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  const OnboardingSlideWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AssetsApp.icons.values
              .firstWhere((icon) => icon.path == imagePath)
              .svg(
                width: MyResponsive.width(context, value: 300),
                height: MyResponsive.height(context, value: 350),
              ),
          const SizedBox(height: 32),
          Text(
            title,
            style: TextStylesApp.onBoardingTitle.copyWith(
              color: ColorsApp.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStylesApp.onBoardingSubtitle.copyWith(
              color: ColorsApp.sconedTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
