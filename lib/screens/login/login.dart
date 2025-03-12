import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/bloc/login/login_bloc.dart';
import 'package:drugpromotion/core/enums/auth_status.dart';
import 'package:drugpromotion/core/repositories/login.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/core/widgets/text_field/text_field.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginRepository()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status.isLoadSuccess) {
                context.read<AuthenticationBloc>().add(
                      AuthenticationStatusChanged(
                        status: AuthenticationStatus.authenticated,
                      ),
                    );
              } else if (state.status.isLoadFailure) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    content: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Text(state.error!),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.status.isAuthenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.main,
                  (_) => false,
                );
              }
            },
          ),
        ],
        child: KeyboardDismisser(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logo),
                    SizedBox(height: 50.h),
                    WTextFormField(
                      controller: loginController,
                      label: AppLocalization.current.login,
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    WTextFormField(
                      controller: passwordController,
                      label: AppLocalization.current.password,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Builder(
              builder: (context) {
                return BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return WButton(
                      loading: state.status.isLoading,
                      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      onTap: () {
                        context.read<LoginBloc>().add(LoginRequestedEvent(
                              login: loginController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                      },
                      text: AppLocalization.current.login,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
