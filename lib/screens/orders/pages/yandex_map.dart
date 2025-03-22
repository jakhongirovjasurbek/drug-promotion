import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapScreen extends StatefulWidget {
  const YandexMapScreen({super.key});

  @override
  _YandexMapScreenState createState() => _YandexMapScreenState();
}

class _YandexMapScreenState extends State<YandexMapScreen> {
  late YandexMapController _mapController;
  Point? _currentLocation;
  final Point _destination = Point(
    latitude: 41.338034,
    longitude: 69.334240,
  ); // Example: Moscow

  final mapObjects = <MapObject>[];

  String? estimatedTime;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _drawRoute() async {
    if (_currentLocation == null) return;

    final drivingResult = await YandexDriving.requestRoutes(
      points: [
        RequestPoint(
          point: _currentLocation!,
          requestPointType: RequestPointType.wayPoint,
        ),
        RequestPoint(
          point: _destination,
          requestPointType: RequestPointType.wayPoint,
        )
      ],
      drivingOptions: const DrivingOptions(),
    );

    final results = (await drivingResult.$2).routes;

    estimatedTime = results?.first.metadata.weight.time.text;
    print("Estimated Time: $estimatedTime minutes");

    if (results?.isNotEmpty ?? false) {
      mapObjects.add(PolylineMapObject(
        mapId: const MapObjectId('route'),
        polyline: results!.first.geometry,
        strokeColor: Colors.green,
        strokeWidth: 5,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      mapObjects: mapObjects,
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController.toggleUserLayer(visible: true);
      },
    );
  }
}
