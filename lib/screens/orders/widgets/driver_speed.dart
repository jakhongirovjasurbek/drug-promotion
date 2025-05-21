import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/helpers/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class DriverSpeedWidget extends StatefulWidget {
  const DriverSpeedWidget({super.key});

  @override
  State<DriverSpeedWidget> createState() => _DriverSpeedWidgetState();
}

class _DriverSpeedWidgetState extends State<DriverSpeedWidget> {
  double? currentSpeedKmh;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    bool serviceEnabled = await LocationService.instance.isServiceEnabled;
    if (!serviceEnabled) {
      serviceEnabled = await LocationService.instance.requestService();
      if (!serviceEnabled) return;
    }

    LocationPermission permissionGranted = await LocationService.instance.hasPermission;
    if (permissionGranted == LocationPermission.denied) {
      final isPermissionGranted = await LocationService.instance.requestPermission();
      if (isPermissionGranted) return;
    }

    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
        timeLimit: Duration(milliseconds: 1000),
      ),
    ).listen((newLocation) {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Geolocator.getPositionStream(),
        builder: (context, snapshot) {
          if (snapshot.data?.speed == null) return SizedBox();

          final speed = snapshot.data!.speed * 3.6;

          return Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.red, width: 3.w),
            ),
            child: Text(
              '${speed.toInt()}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.blackish,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
            ),
          );
        });
  }
}
