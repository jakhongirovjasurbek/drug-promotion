import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/repositories/driver_location.dart';
import 'package:drugpromotion/core/repositories/firebase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final _firebaseRepository = FirebaseRepository();
  final DriverLocationRepository locationRepository;

  Timer? _locationTimer;

  MainBloc({required this.locationRepository}) : super(MainState()) {
    on<MainEvent$SendFCMToken>(_onSendFCMToken);
    on<MainEvent$StartLocationUpdates>(_onStartLocationUpdates);
    on<MainEvent$StopLocationUpdates>(_onStopLocationUpdates);
  }

  Future<void> _onSendFCMToken(
    MainEvent$SendFCMToken event,
    Emitter<MainState> emit,
  ) async {
    final response = await _firebaseRepository.sendFCMToken(event.token);
    response.either(
      (failure) => print('FCM token send failed'),
      (_) => print('FCM token sent successfully'),
    );
  }

  void _onStartLocationUpdates(
    MainEvent$StartLocationUpdates event,
    Emitter<MainState> emit,
  ) {
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        await _ensureLocationPermission();

        final position = await Geolocator.getCurrentPosition();

        await locationRepository.postDriverLocation(
          position.latitude,
          position.longitude,
        );
      } catch (_) {}
    });
  }

  void _onStopLocationUpdates(
    MainEvent$StopLocationUpdates event,
    Emitter<MainState> emit,
  ) {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  @override
  Future<void> close() {
    _locationTimer?.cancel();
    return super.close();
  }
}

Future<void> _ensureLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied.');
  }
}
