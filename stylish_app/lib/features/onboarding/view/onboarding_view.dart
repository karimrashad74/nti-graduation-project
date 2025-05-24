import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stylish_app/core/constants/colors_app.dart';
import 'package:stylish_app/core/constants/text_styles_app.dart';
import 'package:stylish_app/core/helper/navigation_helper.dart';
import 'package:stylish_app/core/helper/status_bar_helper.dart';
import 'package:stylish_app/features/get_start/view/get_start_view.dart';
import 'package:stylish_app/features/onboarding/viewmodel/onboarding_cubit.dart';

import '../../../config/localisation/translations_keys.dart';
import '../widgets/onboarding_slide_widget.dart';

class OnboardingView extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusBarHelper.setPrimaryStatusBar();
    return Scaffold(
      backgroundColor: ColorsApp.backgroundOnboarding,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => OnboardingCubit(),
          child: BlocListener<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingCompleted) {
                NavigationHelper.pushAndRemoveUntilTo(context, GetStartView());
              }
            },
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                final cubit = context.read<OnboardingCubit>();
                return OnBoardingSlider(
                  speed: 1.0,
                  headerBackgroundColor: ColorsApp.backgroundOnboarding,
                  background:
                      cubit.slides
                          .map((slide) => const SizedBox.shrink())
                          .toList(),
                  pageBodies:
                      cubit.slides
                          .map(
                            (slide) => OnboardingSlideWidget(
                              imagePath: slide.imagePath,
                              title: slide.title,
                              subtitle: slide.subtitle,
                            ),
                          )
                          .toList(),
                  finishButtonText: TranslationsKeys.onboardingGetStarted.tr,
                  finishButtonStyle: FinishButtonStyle(
                    backgroundColor: ColorsApp.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onFinish: () => cubit.completeOnboarding(),
                  skipFunctionOverride: () => cubit.completeOnboarding(),
                  totalPage: cubit.slides.length,
                  controllerColor: Colors.black,
                  skipTextButton: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7, right: 16),
                      child: Text(
                        TranslationsKeys.onboardingSkip.tr,
                        style: TextStylesApp.onBoardingButton.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
