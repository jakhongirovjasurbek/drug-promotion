part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = const AuthUserModel(
      id: '',
      username: '',
      phoneNumber: '',
    ),
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(
    AuthUserModel user,
  ) : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.redirected(String shareLink, AuthUserModel user)
      : this._(
          status: AuthenticationStatus.redirected,
          user: user,
        );

  final AuthenticationStatus status;
  final AuthUserModel user;

  @override
  List<Object> get props => [status, user];
}
