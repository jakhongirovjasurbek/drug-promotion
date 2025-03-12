part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

final class LoginRequestedEvent extends LoginEvent {
  final String login;
  final String password;

  const LoginRequestedEvent({
    required this.login,
    required this.password,
  });
}

final class LoginPasswordVisibilityEvent extends LoginEvent {
  final bool isVisible;

  const LoginPasswordVisibilityEvent(this.isVisible);
}
