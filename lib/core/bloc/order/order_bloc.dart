import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:drugpromotion/core/repositories/cargo.dart';
import 'package:drugpromotion/screens/home/args/order_args.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CargoRepository repository;

  OrderBloc(this.repository) : super(OrderState()) {
    on<OrderRefreshEvent>((event, emit) async {
      if (state.activeCargo == null) return;

      Position driverPosition;

      try {
        driverPosition = await _getDriverLocation();
      } catch (e) {
        debugPrint('Failed to get location: $e');
        return;
      }

      if (state.orderDetails?.status.isDelivering == true) {
        final newMapObjects = <MapObject>[];

        Position driverPosition = await _getDriverLocation();

        final driverLocation = Point(
          latitude: driverPosition.latitude,
          longitude: driverPosition.longitude,
        );

        final order = state.activeCargo!.orders.firstWhere((order) => order.orderId == state.orderDetails!.orderId);

        final response = await YandexDriving.requestRoutes(
          points: [
            RequestPoint(
              point: driverLocation,
              requestPointType: RequestPointType.wayPoint,
            ),
            RequestPoint(
              point: Point(
                latitude: order.latitude.toDouble(),
                longitude: order.longitude.toDouble(),
              ),
              requestPointType: RequestPointType.wayPoint,
            )
          ],
          drivingOptions: const DrivingOptions(),
        );

        final routeResult = await response.$2;

        if (routeResult.routes != null && routeResult.routes!.isNotEmpty) {
          final geometry = routeResult.routes!.first.geometry;

          final data = routeResult.routes!.first;

          final time = data.metadata.weight.timeWithTraffic;

          final distance = data.metadata.weight.distance;

          final routePolyline = PolylineMapObject(
            mapId: const MapObjectId('accepted_route'),
            polyline: geometry,
            strokeColor: Colors.green,
            strokeWidth: 8,
          );

          newMapObjects.add(routePolyline);

          newMapObjects.add(PlacemarkMapObject(
            mapId: MapObjectId('order_${order.latitude}_${order.longitude}'),
            point: Point(
              latitude: order.latitude.toDouble(),
              longitude: order.longitude.toDouble(),
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(AppAssets.orderMark), // Your custom pin
                scale: 1.5,
              ),
            ),
            onTap: (_, __) {},
          ));

          emit(state.copyWith(mapObjects: newMapObjects));

          return;
        }
      }

      final driverLocation = Point(latitude: driverPosition.latitude, longitude: driverPosition.longitude);

      final sortedOrders = _sortOrdersByProximity(driverLocation, state.activeCargo!.orders);

      final routePoints = _createRoutePoints(driverLocation, sortedOrders);

      final response = await YandexDriving.requestRoutes(
        points: routePoints,
        drivingOptions: const DrivingOptions(),
      );

      final routeResult = await response.$2;

      if (routeResult.routes != null && routeResult.routes!.isNotEmpty) {
        final geometry = routeResult.routes!.first.geometry;

        final updatedMapObjects = List<MapObject>.from(state.mapObjects);
        updatedMapObjects.removeWhere((obj) => obj.mapId.value == 'route');

        final routePolyline = PolylineMapObject(
          mapId: const MapObjectId('route'),
          polyline: geometry,
          strokeColor: Colors.blue,
          strokeWidth: 5,
        );

        updatedMapObjects.add(routePolyline);

        emit(state.copyWith(mapObjects: updatedMapObjects));
      }
    });

    on<OrderGetDetailsEvent>((event, emit) {
      emit(state.copyWith(getStatus: LoadingStatus.loadSuccess, activeCargo: event.cargo));
    });

    on<OrderGetCargoEvent>((event, emit) async {
      emit(state.copyWith(getStatus: LoadingStatus.loading));

      final response = await repository.getCargoList(OrderArgs(status: CargoStatus.onTheWay));

      response.either(
        (failure) {
          emit(state.copyWith(
            getStatus: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (cargo) {
          if (cargo.isEmpty) {
            emit(state.copyWith(
              getStatus: LoadingStatus.loadSuccess,
            ));

            return;
          }

          emit(state.copyWith(
            getStatus: LoadingStatus.loadSuccess,
            activeCargo: cargo.first,
          ));
        },
      );
    });

    on<OrderCreateMapObjectsEvent>((event, emit) async {
      Position driverPosition = await _getDriverLocation();

      final driverLocation = Point(
        latitude: driverPosition.latitude,
        longitude: driverPosition.longitude,
      );

      final sortedOrders = _sortOrdersByProximity(driverLocation, state.activeCargo!.orders);

      final newMapObjects = <MapObject>[];

      final placeMarks = sortedOrders.map((order) {
        return PlacemarkMapObject(
          mapId: MapObjectId('order_${order.latitude}_${order.longitude}'),
          point: Point(
            latitude: order.latitude.toDouble(),
            longitude: order.longitude.toDouble(),
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(AppAssets.orderMark), // Your custom pin
              scale: 1.5,
            ),
          ),
          onTap: (_, __) {},
        );
      }).toList();

      newMapObjects.addAll(placeMarks);

      final routePoints = _createRoutePoints(driverLocation, sortedOrders);

      final response = await YandexDriving.requestRoutes(
        points: routePoints,
        drivingOptions: const DrivingOptions(),
      );

      final routeResult = await response.$2;

      if (routeResult.routes != null && routeResult.routes!.isNotEmpty) {
        final geometry = routeResult.routes!.first.geometry;

        final routePolyline = PolylineMapObject(
          mapId: const MapObjectId('route'),
          polyline: geometry,
          strokeColor: Colors.blue,
          strokeWidth: 5,
        );

        newMapObjects.add(routePolyline);
      }

      final updatedCargo = state.activeCargo!.copyWith(orders: sortedOrders);

      emit(state.copyWith(
        mapObjects: newMapObjects,
        activeCargo: updatedCargo,
      ));
    });

    on<OrderAcceptEvent>((event, emit) async {
      emit(state.copyWith(orderStatus: LoadingStatus.loading));

      final newMapObjects = <MapObject>[];

      Position driverPosition = await _getDriverLocation();

      final driverLocation = Point(
        latitude: driverPosition.latitude,
        longitude: driverPosition.longitude,
      );

      final order = state.activeCargo!.orders.firstWhere((order) => order.orderId == event.orderId);

      final response = await YandexDriving.requestRoutes(
        points: [
          RequestPoint(
            point: driverLocation,
            requestPointType: RequestPointType.wayPoint,
          ),
          RequestPoint(
            point: Point(
              latitude: order.latitude.toDouble(),
              longitude: order.longitude.toDouble(),
            ),
            requestPointType: RequestPointType.wayPoint,
          )
        ],
        drivingOptions: const DrivingOptions(),
      );

      final routeResult = await response.$2;

      if (routeResult.routes != null && routeResult.routes!.isNotEmpty) {
        final geometry = routeResult.routes!.first.geometry;

        final data = routeResult.routes!.first;

        final time = data.metadata.weight.timeWithTraffic;

        final distance = data.metadata.weight.distance;

        final routePolyline = PolylineMapObject(
          mapId: const MapObjectId('accepted_route'),
          polyline: geometry,
          strokeColor: Colors.green,
          strokeWidth: 8,
        );

        newMapObjects.add(routePolyline);

        newMapObjects.add(PlacemarkMapObject(
          mapId: MapObjectId('order_${order.latitude}_${order.longitude}'),
          point: Point(
            latitude: order.latitude.toDouble(),
            longitude: order.longitude.toDouble(),
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(AppAssets.orderMark), // Your custom pin
              scale: 1.5,
            ),
          ),
          onTap: (_, __) {},
        ));

        final response = await repository.acceptOrder(
          cargoId: event.cargoId,
          orderId: event.orderId,
          rowId: event.rowId,
          expectedDistance: distance.value! / 1000,
          expectedTime: time.value! ~/ 60,
        );

        response.either(
          (failure) {
            emit(state.copyWith(orderStatus: LoadingStatus.loadFailure));
          },
          (_) {
            emit(state.copyWith(
              orderStatus: LoadingStatus.loadSuccess,
              orderDetails: OrderDetails(
                orderId: order.orderId,
                rowId: order.rowId,
                distance: distance.value,
                time: time.value ?? 0,
                status: OrderStatus.delivering,
              ),
              mapObjects: newMapObjects,
            ));
          },
        );
      }
    });

    on<OrderEndEvent>((event, emit) async {
      emit(state.copyWith(orderStatus: LoadingStatus.loading));

      final response = await repository.uploadOrderImage(
        path: event.image.path,
        cargoId: event.cargoId,
        rowId: event.rowId,
      );

      response.either(
        (failure) {
          emit(state.copyWith(
            orderStatus: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (_) {
          add(_OrderCompleteEvent(rowId: event.rowId, orderId: event.orderId, cargoId: event.cargoId));
        },
      );

      response.either(
        (failure) {},
        (data) {},
      );
    });

    on<_OrderCompleteEvent>((event, emit) async {
      emit(state.copyWith(orderStatus: LoadingStatus.loading));

      final response = await repository.completeOrder(
        cargoId: event.cargoId,
        orderId: event.orderId,
        rowId: event.rowId,
        realDistance: state.orderDetails!.distance!,
        expectedTime: state.orderDetails!.time,
      );

      response.either(
        (failure) {
          emit(state.copyWith(
            orderStatus: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (data) {
          final orders = state.activeCargo?.orders.map((order) {
            if (order.orderId == event.orderId) {
              return order.copyWith(isDelivered: true);
            }

            return order;
          }).toList();

          emit(state.copyWith(
            orderStatus: LoadingStatus.loadSuccess,
            orderDetails: OrderDetails(
              rowId: event.rowId,
              orderId: event.orderId,
              distance: null,
              time: 0,
              status: OrderStatus.pure,
            ),
            activeCargo: state.activeCargo?.copyWith(orders: orders),
          ));
        },
      );
    });
  }

  Future<Position> _getDriverLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw Exception('Location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  List<OrderModel> _sortOrdersByProximity(Point driverLocation, List<OrderModel> orders) {
    final visited = <OrderModel>[];
    var remaining = List<OrderModel>.from(orders);
    var currentPoint = driverLocation;

    while (remaining.isNotEmpty) {
      remaining.sort((first, second) {
        double distA = _distance(
          currentPoint,
          Point(
            latitude: first.latitude.toDouble(),
            longitude: first.longitude.toDouble(),
          ),
        );

        double distB = _distance(
          currentPoint,
          Point(
            latitude: second.latitude.toDouble(),
            longitude: second.longitude.toDouble(),
          ),
        );

        return distA.compareTo(distB);
      });

      final nextOrder = remaining.removeAt(0);

      visited.add(nextOrder);

      currentPoint = Point(
        latitude: nextOrder.latitude.toDouble(),
        longitude: nextOrder.longitude.toDouble(),
      );
    }

    return visited;
  }

  double _distance(Point a, Point b) {
    final dx = a.latitude - b.latitude;
    final dy = a.longitude - b.longitude;
    return dx * dx + dy * dy;
  }

  List<RequestPoint> _createRoutePoints(Point driverLocation, List<OrderModel> sortedOrders) {
    final points = <RequestPoint>[
      RequestPoint(
        point: driverLocation,
        requestPointType: RequestPointType.wayPoint,
      ),
    ];

    for (final order in sortedOrders) {
      points.add(RequestPoint(
        point: Point(
          latitude: order.latitude.toDouble(),
          longitude: order.longitude.toDouble(),
        ),
        requestPointType: RequestPointType.wayPoint,
      ));
    }

    return points;
  }
}
