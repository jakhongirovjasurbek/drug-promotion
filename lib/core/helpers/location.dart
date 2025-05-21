import 'package:geolocator/geolocator.dart';

final class LocationService {
  static late LocationService instance;

  const LocationService._();

  static Future<void> initialize() async {
    instance = const LocationService._();
  }

  Future<bool> get isServiceEnabled => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> get hasPermission => Geolocator.checkPermission();

  Future<bool> requestService() async {
    if (await isServiceEnabled) return true;

    return await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> requestPermission() async {
    if ((await hasPermission) == LocationPermission.always) return true;

    final response = await Geolocator.requestPermission();

    if (response == LocationPermission.always || response == LocationPermission.whileInUse) return true;

    return false;
  }
}
