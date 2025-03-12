part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final LoadingStatus status;
  final bool isPasswordVisible;
  final String? error;

  const LoginState({
    this.status = LoadingStatus.pure,
    this.isPasswordVisible = false,
    this.error,
  });

  LoginState copyWith({
    LoadingStatus? status,
    bool? isPasswordVisible,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, isPasswordVisible, error];
}
