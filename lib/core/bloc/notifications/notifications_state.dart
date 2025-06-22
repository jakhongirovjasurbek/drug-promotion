part of 'notifications_bloc.dart';

@immutable
final class NotificationsState extends Equatable {
  final LoadingStatus getStatus;
  final List<NotificationModel> notifications;

  const NotificationsState({
    this.getStatus = LoadingStatus.pure,
    this.notifications = const [],
  });

  NotificationsState copyWith({
    LoadingStatus? getStatus,
    List<NotificationModel>? notifications,
  }) {
    return NotificationsState(
      getStatus: getStatus ?? this.getStatus,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [getStatus, notifications];
}
