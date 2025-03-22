import 'package:equatable/equatable.dart';

final class OrderModel extends Equatable {
  final String orderId;
  final String rowId;
  final String address;
  final bool isDelivered;
  final num latitude;
  final num longitude;
  final String client;
  final String clientPhone;
  final num expectedDistance;
  final num distance;
  final int expectedTime;
  final int time;
  final List<dynamic> images;

  const OrderModel({
    required this.orderId,
    required this.rowId,
    required this.address,
    required this.isDelivered,
    required this.latitude,
    required this.longitude,
    required this.client,
    required this.clientPhone,
    required this.expectedDistance,
    required this.distance,
    required this.expectedTime,
    required this.time,
    required this.images,
  });

  @override
  List<Object> get props => [
        orderId,
        rowId,
        address,
        isDelivered,
        latitude,
        longitude,
        client,
        clientPhone,
        expectedDistance,
        distance,
        expectedTime,
        time,
        images,
      ];

  static List<OrderModel> buildList(List orders) {
    return orders.map((order) => OrderModel.fromJson(order)).toList();
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      rowId: json['row_id'],
      address: json['address'],
      isDelivered: json['is_delivered'],
      latitude: json['lat'],
      longitude: json['lng'],
      client: json['client'],
      clientPhone: json['client_phone'],
      expectedDistance: json['expected_distance'],
      distance: json['distance'],
      expectedTime: json['expected_time'],
      time: json['time'],
      images: json['images'],
    );
  }
}
