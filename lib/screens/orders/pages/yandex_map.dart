import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/order/order_bloc.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/screens/orders/widgets/driver_speed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapScreen extends StatefulWidget {
  const YandexMapScreen({super.key});

  @override
  _YandexMapScreenState createState() => _YandexMapScreenState();
}

class _YandexMapScreenState extends State<YandexMapScreen> {
  late YandexMapController mapController;

  String? estimatedTime;

  PlacemarkMapObject? driverPlaceMark;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Stack(
          children: [
            YandexMap(
              mapObjects: state.mapObjects,
              onMapCreated: (controller) async {
                mapController = controller;
                mapController.toggleUserLayer(visible: true);

                await mapController.toggleTrafficLayer(visible: true); // optional but safe to call

                try {
                  final location = await Geolocator.getCurrentPosition();

                  mapController.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: Point(
                          latitude: location.latitude,
                          longitude: location.longitude,
                        ),
                        zoom: 17.5, // higher zoom for better 3D
                        azimuth: 0, // 0 for north up, or set based on direction
                        tilt: 70, // 🎯 this creates the 3D angled view
                      ),
                    ),
                    animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
                  );

                  context.read<OrderBloc>().add(OrderCreateMapObjectsEvent());

                  Geolocator.getPositionStream(
                    locationSettings: LocationSettings(
                      timeLimit: Duration(seconds: 5),
                      distanceFilter: 10,
                      accuracy: LocationAccuracy.bestForNavigation,
                    ),
                  ).listen((currentLocation) {
                    context.read<OrderBloc>().add(OrderRefreshEvent());

                    double heading = currentLocation.heading;

                    mapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: Point(
                            latitude: currentLocation.latitude,
                            longitude: currentLocation.longitude,
                          ),
                          zoom: 17.5,
                          tilt: 45,
                          azimuth: heading, // Update the azimuth based on heading
                        ),
                      ),
                      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
                    );
                  });
                } catch (_) {}
              },
            ),
            Positioned(right: 16.w, top: 16.h, child: const DriverSpeedWidget()),
            Positioned(
              right: 16.w,
              bottom: 140.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WScale(
                    onTap: () async {
                      final cameraPosition = await mapController.getCameraPosition();

                      mapController.moveCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: cameraPosition.target,
                            zoom: cameraPosition.zoom + 1,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30.w,
                        color: AppColors.blackish,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  WScale(
                    onTap: () async {
                      final cameraPosition = await mapController.getCameraPosition();

                      mapController.moveCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: cameraPosition.target,
                            zoom: cameraPosition.zoom - 1,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 30.w,
                        color: AppColors.blackish,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16.w,
              bottom: 60.h,
              child: WScale(
                onTap: () async {
                  try {
                    final locationData = await Geolocator.getCurrentPosition();

                    final userLocation = Point(
                      latitude: locationData.latitude,
                      longitude: locationData.longitude,
                    );

                    mapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: userLocation,
                          zoom: 25, // higher zoom for better 3D
                          azimuth: 0, // 0 for north up, or set based on direction
                          tilt: 60, // 🎯 this creates the 3D angled view, // Adjust the zoom level as needed
                        ),
                      ),
                    );
                  } catch (_) {}
                },
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.my_location,
                    size: 30.w,
                    color: AppColors.blackish,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
