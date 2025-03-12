import 'package:drugpromotion/core/methods/fade.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/screens/login/login.dart';
import 'package:drugpromotion/screens/main/main.dart';
import 'package:drugpromotion/screens/notifications/notifications.dart';
import 'package:drugpromotion/screens/splash/splash.dart';
import 'package:drugpromotion/screens/unknown/unknown.dart';
import 'package:flutter/widgets.dart';

abstract final class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return fade(
          page: const SplashPage(),
          name: settings.name!,
        );

      case RouteNames.main:
        return fade(
          page: const MainPage(),
          name: settings.name!,
        );

      case RouteNames.login:
        return fade(
          page: const LoginPage(),
          name: settings.name!,
        );

      case RouteNames.notifications:
        return fade(
          page: const NotificationsPage(),
          name: settings.name!,
        );

      default:
        return fade(
          page: const UnknownPage(),
          name: settings.name!,
        );
    }
  }
}
