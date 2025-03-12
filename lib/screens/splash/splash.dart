import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status.isUnauthenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteNames.login,
                (_) => false,
              );
            } else if (state.status.isAuthenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteNames.main,
                (_) => false,
              );
            }
          },
          builder: (context, state) {
            if (state.status.isUnknown) {
              context.read<AuthenticationBloc>().add(GetAuthenticationStatus());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Center(child: Image.asset(AppAssets.logo)),
                CupertinoActivityIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
