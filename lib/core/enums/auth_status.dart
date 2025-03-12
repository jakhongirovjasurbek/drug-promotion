enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  redirected;

  bool get isAuthenticated => this == authenticated;

  bool get isUnauthenticated => this == unauthenticated;

  bool get isRedirected => this == redirected;

  bool get isUnknown => this == unknown;
}
