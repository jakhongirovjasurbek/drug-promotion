import 'dart:async';

import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/methods/setup_locator.dart';
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

void main() {
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

      runApp(const DrugPromotionApp());
    },
    (error, stacktrace) {
      if (kDebugMode) {
        // TODO: Handle exception

        print('Exception, $error, \n$stacktrace');
      }
    },
  );
}

class DrugPromotionApp extends StatelessWidget {
  const DrugPromotionApp({super.key});

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

        return BlocProvider(
          create: (context) => AuthenticationBloc(),
          child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme:
                  const AppBarTheme(backgroundColor: Color(0xFFDAE2E2)),
            ),
            debugShowCheckedModeBanner: false,
            themeAnimationCurve: Curves.slowMiddle,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalization.delegate.supportedLocales,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}
