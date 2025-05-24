import 'package:flutter/material.dart';

class CustomNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final RouteFactory onGenerateRoute;

  const CustomNavigator({
    Key? key,
    required this.navigatorKey,
    required this.initialRoute,
    required this.onGenerateRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}