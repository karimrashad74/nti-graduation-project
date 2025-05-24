import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stylish_app/config/cache/cache_helper.dart';
import 'package:stylish_app/config/cache/cache_keys.dart';
import 'package:stylish_app/config/localisation/translations_keys.dart';
import 'package:stylish_app/core/constants/assets_app.dart';
import 'package:stylish_app/features/onboarding/model/onboarding_slide_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final List<OnboardingSlideModel> slides = [
    OnboardingSlideModel(
      imagePath: AssetsApp.icons.onboarding1.path,
      title: TranslationsKeys.onboardingOneText.tr,
      subtitle: TranslationsKeys.onboardingOneSubText.tr,
    ),
    OnboardingSlideModel(
      imagePath: AssetsApp.icons.onboarding2.path,
      title: TranslationsKeys.onboardingTwoText.tr,
      subtitle: TranslationsKeys.onboardingTwoSubText.tr,
    ),
    OnboardingSlideModel(
      imagePath: AssetsApp.icons.onboarding3.path,
      title: TranslationsKeys.onboardingThreeText.tr,
      subtitle: TranslationsKeys.onboardingThreeSubText.tr,
    ),
  ];

  Future<void> completeOnboarding() async {
    await CacheHelper.saveData(key: CacheKeys.onboardingCompleted, value: true);
    emit(OnboardingCompleted());
  }
}
