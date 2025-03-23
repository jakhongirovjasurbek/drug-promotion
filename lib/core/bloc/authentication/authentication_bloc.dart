import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drugpromotion/assets/constants.dart';
import 'package:drugpromotion/core/enums/auth_status.dart';
import 'package:drugpromotion/core/helpers/storage_repository.dart';
import 'package:drugpromotion/core/methods/setup_locator.dart';
import 'package:drugpromotion/core/models/auth_user.dart';
import 'package:drugpromotion/core/repositories/authentication.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late StreamSubscription _streamSubscription;

  final authRepository = serviceLocator<AuthenticationRepository>();

  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    _streamSubscription = authRepository.status.listen((event) {
      add(AuthenticationStatusChanged(status: event));
    });

    /// Handle `GetAuthenticationStatus` event.
    on<GetAuthenticationStatus>((event, emit) {
      add(const AuthenticationStatusChanged(
        status: AuthenticationStatus.authenticated,
      ));
    });

    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthenticationStatus.unknown:
          emit(const AuthenticationState.unauthenticated());
          break;
        case AuthenticationStatus.authenticated:
          await Future.delayed(Duration(seconds: 1));

          final token =
              StorageRepository.getString(AppConstants.accessTokenKey);

          if (token.isEmpty) {
            emit(const AuthenticationState.unauthenticated());
            return;
          }

          final response = await authRepository.getUser();

          response.either(
            (failure) => emit(const AuthenticationState.unauthenticated()),
            (user) => emit(AuthenticationState.authenticated(user)),
          );
          break;
        case AuthenticationStatus.unauthenticated:
          emit(const AuthenticationState.unauthenticated());
          break;
        case AuthenticationStatus.redirected:
          emit(const AuthenticationState.unauthenticated());
          break;
      }
    });

    on<LogoutRequested>((event, emit) async {
      await StorageRepository.putString(AppConstants.accessTokenKey, '');

      emit(const AuthenticationState.unauthenticated());
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
