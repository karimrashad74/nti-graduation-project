import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/cache/cache_helper.dart';
import '../../../config/cache/cache_keys.dart';
import '../../../core/constants/assets_app.dart';
import '../model/get_start_slide_model.dart';

part 'get_start_state.dart';

class GetStartCubit extends Cubit<GetStartState> {
  GetStartCubit() : super(GetStartInitial());

  final GetStartSlideModel slide = GetStartSlideModel(
    imagePath: AssetsApp.images.getStart.path,
  );

  void completeGetStart() async {
    await CacheHelper.saveData(key: CacheKeys.getStartCompleted, value: true);
    emit(GetStartInitial());
  }
}
