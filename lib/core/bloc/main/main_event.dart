part of 'main_bloc.dart';

@immutable
sealed class MainEvent {
  const MainEvent();
}

final class MainEvent$SendFCMToken extends MainEvent {
  final String token;

  const MainEvent$SendFCMToken(this.token);
}

class MainEvent$StartLocationUpdates extends MainEvent {}

class MainEvent$StopLocationUpdates extends MainEvent {}