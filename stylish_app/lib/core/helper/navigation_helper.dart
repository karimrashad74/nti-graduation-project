import 'package:flutter/material.dart';

class NavigationHelper {
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  static Future<T?> pushReplacementTo<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page), result: result);
  }

  static Future<T?> pushAndRemoveUntilTo<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static Future<void> navigateAfterDelay({
    required BuildContext context,
    required Widget page,
    required Duration delay,
    bool removeAll = false,
  }) async {
    await Future.delayed(delay);
    if (removeAll) {
      pushAndRemoveUntilTo(context, page);
    } else {
      pushReplacementTo(context, page);
    }
  }
}
