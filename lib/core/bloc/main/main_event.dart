part of 'main_bloc.dart';

@immutable
sealed class MainEvent {
  const MainEvent();
}

final class MainEvent$SendFCMToken extends MainEvent {
  final String token;

  const MainEvent$SendFCMToken(this.token);
}
