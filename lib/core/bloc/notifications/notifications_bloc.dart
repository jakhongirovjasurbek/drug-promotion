import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/models/notification.dart';
import 'package:drugpromotion/core/repositories/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final _repository = NotificationRepository();

  NotificationsBloc() : super(NotificationsState()) {
    on<NotificationsEvent$Get>((event, emit) async {
      emit(state.copyWith(getStatus: LoadingStatus.loading));

      final response = await _repository.getNotifications();

      response.either(
        (failure) {
          emit(state.copyWith(getStatus: LoadingStatus.loadFailure));
        },
        (data) {
          emit(state.copyWith(
            getStatus: LoadingStatus.loadSuccess,
            notifications: data,
          ));
        },
      );
    });
  }
}
