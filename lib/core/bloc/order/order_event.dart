part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {
  const OrderEvent();
}

final class OrderGetDetailsEvent extends OrderEvent {
  final CargoModel cargo;

  const OrderGetDetailsEvent({required this.cargo});
}

final class OrderGetCargoEvent extends OrderEvent {}

final class OrderCreateMapObjectsEvent extends OrderEvent {}

final class OrderRefreshEvent extends OrderEvent {}

final class OrderAcceptEvent extends OrderEvent {
  final String orderId;
  final String rowId;
  final String cargoId;

  const OrderAcceptEvent({
    required this.orderId,
    required this.rowId,
    required this.cargoId,
  });
}

final class OrderEndEvent extends OrderEvent {
  final String orderId;
  final String rowId;
  final String cargoId;
  final XFile image;

  const OrderEndEvent({
    required this.image,
    required this.orderId,
    required this.rowId,
    required this.cargoId,
  });
}

final class _OrderCompleteEvent extends OrderEvent {
  final String orderId;
  final String rowId;
  final String cargoId;

  const _OrderCompleteEvent({
    required this.orderId,
    required this.rowId,
    required this.cargoId,
  });
}
