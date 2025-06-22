part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {
  const NotificationsEvent();
}

final class NotificationsEvent$Get extends NotificationsEvent {
  const NotificationsEvent$Get();
}
