import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/bloc/main/main_bloc.dart';
import 'package:drugpromotion/core/helpers/locale.dart';
import 'package:drugpromotion/core/helpers/location.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/home.dart';
import 'package:drugpromotion/screens/main/enums/nav_item_name.dart';
import 'package:drugpromotion/screens/main/widgets/nav_item.dart';
import 'package:drugpromotion/screens/orders/orders.dart';
import 'package:drugpromotion/screens/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavItemName selectedNavItem = BottomNavItemName.home;

  late MainBloc mainBloc;

  @override
  void initState() {
    mainBloc = MainBloc();

    FirebaseMessaging.instance.getToken().then((token) {
      if (token == null) return;

      mainBloc.add(MainEvent$SendFCMToken(token));
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      mainBloc.add(MainEvent$SendFCMToken(fcmToken));
    }).onError((err) {
      return;
    });

    LocationService.initialize();

    requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(message.notification?.title ?? ''),
          actions: [
            WButton(
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.notifications);
              },
              text: AppLocalization.of(context).notifications,
            )
          ],
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.of(context).pushNamed(RouteNames.notifications);
    });

    super.initState();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();

    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('Permission declined');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppLocaleNotifier>();

    return BlocProvider.value(
      value: mainBloc,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status.isUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.login,
              (_) => false,
            );
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: selectedNavItem.index,
            children: [
              HomePage(),
              OrdersPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  color: Colors.black.withAlpha(30),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: SizedBox(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WBottomNavItem(
                      name: BottomNavItemName.home,
                      title: AppLocalization.current.home,
                      icon: AppAssets.home,
                      onTap: (value) {
                        setState(() {
                          selectedNavItem = value;
                        });
                      },
                      isActive: selectedNavItem.isHome,
                    ),
                    WBottomNavItem(
                      name: BottomNavItemName.orders,
                      title: AppLocalization.current.my_orders,
                      icon: AppAssets.myOrders,
                      onTap: (value) {
                        setState(() {
                          selectedNavItem = value;
                        });
                      },
                      isActive: selectedNavItem.isOrders,
                    ),
                    WBottomNavItem(
                      name: BottomNavItemName.profile,
                      title: AppLocalization.current.profile,
                      icon: AppAssets.profile,
                      onTap: (value) {
                        setState(() {
                          selectedNavItem = value;
                        });
                      },
                      isActive: selectedNavItem.isProfile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
