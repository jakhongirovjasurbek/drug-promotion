import 'dart:math';

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

  static List<OrderModel> buildList(List orders) {
    return orders.map((order) => OrderModel.fromJson(order)).toList();
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final mockLocation = getMockTashkentLocation();

    return OrderModel(
      orderId: json['order_id'],
      rowId: json['row_id'],
      address: json['address'],
      isDelivered: json['is_delivered'],
      latitude: mockLocation['latitude']!.toDouble(),
      // json['lat'],
      longitude: mockLocation['longitude']!.toDouble(),
      // json['lng'],
      client: json['client'],
      clientPhone: json['client_phone'],
      expectedDistance: json['expected_distance'],
      distance: json['distance'],
      expectedTime: json['expected_time'],
      time: json['time'],
      images: json['images'],
    );
  }

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

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, rowId: $rowId, address: $address, isDelivered: $isDelivered, latitude: $latitude, longitude: $longitude, client: $client, clientPhone: $clientPhone, expectedDistance: $expectedDistance, distance: $distance, expectedTime: $expectedTime, time: $time, images: $images}';
  }

  OrderModel copyWith({
    String? orderId,
    String? rowId,
    String? address,
    bool? isDelivered,
    num? latitude,
    num? longitude,
    String? client,
    String? clientPhone,
    num? expectedDistance,
    num? distance,
    int? expectedTime,
    int? time,
    List<dynamic>? images,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      rowId: rowId ?? this.rowId,
      address: address ?? this.address,
      isDelivered: isDelivered ?? this.isDelivered,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      client: client ?? this.client,
      clientPhone: clientPhone ?? this.clientPhone,
      expectedDistance: expectedDistance ?? this.expectedDistance,
      distance: distance ?? this.distance,
      expectedTime: expectedTime ?? this.expectedTime,
      time: time ?? this.time,
      images: images ?? this.images,
    );
  }
}

/// Returns a random mock location (latitude and longitude) inside Tashkent
Map<String, double> getMockTashkentLocation() {
  final random = Random();

  // Approximate bounding box around Tashkent
  const double minLat = 41.2000;
  const double maxLat = 41.4000;
  const double minLng = 69.1500;
  const double maxLng = 69.3500;

  double lat = minLat + random.nextDouble() * (maxLat - minLat);
  double lng = minLng + random.nextDouble() * (maxLng - minLng);

  return {
    'latitude': lat,
    'longitude': lng,
  };
}
