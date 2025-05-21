part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  final LoadingStatus getStatus;
  final CargoModel? activeCargo;
  final List<MapObject> mapObjects;
  final String? error;
  final OrderDetails? orderDetails;
  final LoadingStatus orderStatus;

  const OrderState({
    this.getStatus = LoadingStatus.pure,
    this.orderStatus = LoadingStatus.pure,
    this.mapObjects = const [],
    this.activeCargo,
    this.error,
    this.orderDetails,
  });

  OrderState copyWith({
    LoadingStatus? getStatus,
    CargoModel? activeCargo,
    List<MapObject>? mapObjects,
    String? error,
    OrderDetails? orderDetails,
    LoadingStatus? orderStatus,
  }) {
    return OrderState(
      getStatus: getStatus ?? this.getStatus,
      activeCargo: activeCargo ?? this.activeCargo,
      mapObjects: mapObjects ?? this.mapObjects,
      error: error ?? this.error,
      orderDetails: orderDetails ?? this.orderDetails,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  List<Object?> get props => [getStatus, mapObjects, activeCargo, error, orderDetails, orderStatus];
}

class OrderDetails extends Equatable {
  final double? distance;
  final double time;
  final OrderStatus status;
  final String orderId;
  final String rowId;

  const OrderDetails({
    required this.distance,
    required this.time,
    required this.status,
    required this.orderId,
    required this.rowId,
  });

  OrderDetails copyWith({
    double? distance,
    double? time,
    OrderStatus? status,
    String? orderId,
    String? rowId,
  }) {
    return OrderDetails(
      distance: distance ?? this.distance,
      time: time ?? this.time,
      status: status ?? this.status,
      orderId: orderId ?? this.orderId,
      rowId: rowId ?? this.rowId,
    );
  }

  @override
  List<Object?> get props => [distance, time, status, orderId, rowId];
}
