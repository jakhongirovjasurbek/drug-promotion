import 'package:camera/camera.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/methods/fade.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/screens/home/pages/cargo_detail.dart';
import 'package:drugpromotion/screens/login/login.dart';
import 'package:drugpromotion/screens/main/main.dart';
import 'package:drugpromotion/screens/notifications/notifications.dart';
import 'package:drugpromotion/screens/orders/pages/camera_view.dart';
import 'package:drugpromotion/screens/orders/pages/saved_images.dart';
import 'package:drugpromotion/screens/profile/pages/email.dart';
import 'package:drugpromotion/screens/profile/pages/languages.dart';
import 'package:drugpromotion/screens/profile/pages/order_history.dart';
import 'package:drugpromotion/screens/profile/pages/phone_number.dart';
import 'package:drugpromotion/screens/profile/pages/username.dart';
import 'package:drugpromotion/screens/splash/splash.dart';
import 'package:drugpromotion/screens/unknown/unknown.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      case RouteNames.cargoDetail:
        return fade(
          page: CargoDetail(cargo: settings.arguments as CargoModel),
          name: settings.name!,
        );

      case RouteNames.orderHistory:
        return fade(
          page: BlocProvider.value(
            value: settings.arguments as CargoBloc,
            child: OrderHistoryPage(),
          ),
          name: settings.name!,
        );

      case RouteNames.username:
        return fade(
          page: UsernamePage(),
          name: settings.name!,
        );

      case RouteNames.phoneNumber:
        return fade(
          page: PhoneNumberPage(),
          name: settings.name!,
        );

      case RouteNames.email:
        return fade(
          page: EmailPage(),
          name: settings.name!,
        );

      case RouteNames.language:
        return fade(
          page: LanguagesPage(),
          name: settings.name!,
        );

      case RouteNames.photo:
        return fade<XFile>(
          page: CameraView(),
          name: settings.name!,
        );

      case RouteNames.savedImages:
        return fade<List<XFile>>(
          page: SavedImagesPage(),
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
