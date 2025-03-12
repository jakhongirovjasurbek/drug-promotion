import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/repositories/login.dart';
import 'package:drugpromotion/screens/login/args/args.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(const LoginState()) {
    on<LoginRequestedEvent>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));

      final args = LoginArgs(user: event.login, password: event.password);

      final response = await repository.login(args);

      response.either(
        (failure) {
          emit(state.copyWith(
            status: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (token) {
          emit(state.copyWith(
            status: LoadingStatus.loadSuccess,
            token: token,
          ));
        },
      );
    });

    on<LoginPasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: event.isVisible));
    });
  }
}
