// import 'package:yandex_mapkit/yandex_mapkit.dart';
// import 'package:flutter/material.dart';
//
// class RouteService {
//   final YandexMapController mapController;
//   RouteService(this.mapController);
//
//   Future<void> drawSegmentedRoute(List<Point> waypoints) async {
//     // 1. Build request points
//     final points = <RequestPoint>[
//       RequestPoint(
//         point: waypoints.first,
//         requestPointType: RequestPointType.wayPoint,
//       ),
//       for (int i = 1; i < waypoints.length; i++)
//         RequestPoint(
//           point: waypoints[i],
//           requestPointType: RequestPointType.wayPoint,
//         ),
//     ];
//
//     // 2. Make route request
//     final result = await YandexDriving.requestRoutes(
//       points: points,
//       drivingOptions: const DrivingOptions(),
//     );
//
//     final route = result.$2.routes?.first;
//     if (route == null) {
//       print('No route found.');
//       return;
//     }
//
//     final legs = route.legs ?? [];
//     final colors = [
//       Colors.green,
//       Colors.orange,
//       Colors.blue,
//       Colors.purple,
//       Colors.red,
//       Colors.teal,
//       Colors.pink
//     ];
//
//     // 3. Remove existing segments (by ID pattern)
//     final allMapObjects = await mapController.getMapObjects();
//     final remainingObjects = allMapObjects.where((obj) =>
//     !(obj.mapId.value.startsWith('route_leg_'))).toList();
//     await mapController(remainingObjects);
//
//     // 4. Draw segmented route
//     final newRouteSegments = <MapObject>[];
//
//     for (int i = 0; i < legs.length; i++) {
//       final leg = legs[i];
//
//       final polyline = PolylineMapObject(
//         mapId: MapObjectId('route_leg_$i'),
//         polyline: Polyline(points: leg.geometry),
//         strokeColor: colors[i % colors.length],
//         strokeWidth: 5.5,
//         outlineColor: Colors.black.withOpacity(0.3),
//         outlineWidth: 1.5,
//       );
//
//       newRouteSegments.add(polyline);
//
//       print(
//           'Leg $i: Distance: ${leg.distance?.text}, Duration: ${leg.duration?.text}');
//     }
//
//     // 5. Add to map
//     await mapController.setMapObjects([
//       ...remainingObjects,
//       ...newRouteSegments,
//     ]);
//   }
// }