import 'dart:async';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/bloc/main/main_bloc.dart';
import 'package:drugpromotion/core/bloc/order/order_bloc.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/helpers/locale.dart';
import 'package:drugpromotion/core/methods/setup_locator.dart';
import 'package:drugpromotion/core/repositories/cargo.dart';
import 'package:drugpromotion/core/routes/routes.dart';
import 'package:drugpromotion/firebase_options.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await ScreenUtil.ensureScreenSize();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      await setupLocator();

      await SentryFlutter.init(
        (options) {
          options.dsn =
              'https://cb88510339b2c4e1c667db72aee63c1e@o4509258176397312.ingest.de.sentry.io/4509258177773648';
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
          // We recommend adjusting this value in production.
          options.tracesSampleRate = 1.0;
          // The sampling rate for profiling is relative to tracesSampleRate
          // Setting to 1.0 will profile 100% of sampled transactions:
          options.profilesSampleRate = 1.0;
        },
        appRunner: () => runApp(SentryWidget(child: const DrugPromotionApp())),
      );
    },
    (error, stacktrace) {
      Sentry.captureException(error, stackTrace: stacktrace);

      if (kDebugMode) {
        print('Exception, $error, \n$stacktrace');
      }
    },
  );
}

class DrugPromotionApp extends StatefulWidget {
  const DrugPromotionApp({super.key});

  @override
  State<DrugPromotionApp> createState() => _DrugPromotionAppState();
}

class _DrugPromotionAppState extends State<DrugPromotionApp> {
  final repository = CargoRepository();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        ScreenUtil.init(context);

        return ChangeNotifierProvider(
          create: (_) => AppLocaleNotifier(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthenticationBloc(),
              ),
              BlocProvider(
                create: (context) => OrderBloc(repository),
              ),
              BlocProvider(
                create: (context) => CargoBloc(repository),
              ),
              BlocProvider(
                create: (context) => MainBloc(),
              ),
            ],
            child: Builder(
              builder: (context) {
                final appLocale = context.watch<AppLocaleNotifier>();

                return MaterialApp(
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFDAE2E2)),
                  ),
                  debugShowCheckedModeBanner: false,
                  themeAnimationCurve: Curves.slowMiddle,
                  navigatorObservers: [ChuckerFlutter.navigatorObserver],
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                  locale: Locale(appLocale.locale),
                  supportedLocales: AppLocalization.delegate.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalization.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
