import 'package:flutter/services.dart';

import '../constants/colors_app.dart';

class StatusBarHelper {
  static void setPrimaryStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorsApp.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
